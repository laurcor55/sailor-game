class Player
  attr_accessor :velocity, :direction

  def initialize(x, y)
    @x_position = x # store the horizontal
    @y_position = y # and vertical positions
    @z_position = 0 # (not worried about z just yet)

    self.velocity = 0 # velocity stored in polar magnitude
    self.direction = 0 # and angle

    @image = Gosu::Image.new('media/player.png') # just a png of a circle
    @font = Gosu::Font.new(20) # for debugging
  end

  def accelerate(magnitude, direction)
    delta_h_velocity = magnitude * Math.cos(direction) # acceleration applies a horizontal
    delta_v_velocity = magnitude * Math.sin(direction) # and vertical change in velocity

    h_velocity = self.velocity * Math.cos(self.direction) + delta_h_velocity
    v_velocity = self.velocity * Math.sin(self.direction) + delta_v_velocity

    self.velocity = Math.sqrt(h_velocity*h_velocity + v_velocity*v_velocity)
    self.direction = Math.atan2(v_velocity, h_velocity)
  end

  def halt
    self.velocity = 0 #stop
  end

  # apply velocity to the position
  def update(dt)
    h_velocity = dt * self.velocity * Math.cos(self.direction)
    v_velocity = dt * self.velocity * Math.sin(self.direction)
    @x_position += h_velocity
    @y_position += v_velocity
    halt if out_of_bounds?
  end

  def draw
    @image.draw(
      @x_position,
      @y_position,
      @z_position,
      0.15, 0.15
    )

    @font.draw_text("velocity: #{self.velocity}\ndirection: #{self.direction}", 0, 0, 0)
  end

  private

    def out_of_bounds?
      @x_position <= 0 || @x_position >= (640-20) || @y_position <= 0 || @y_position >= (480-20)
    end
end