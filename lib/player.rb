class Player
  MIN_HORIZONTAL_POSITION = 0
  MAX_HORIZONTAL_POSITION = 620
  MIN_VERTICAL_POSITION = 0
  MAX_VERTICAL_POSITION = 460

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
    limit_position
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

    def limit_position
      if @x_position < MIN_HORIZONTAL_POSITION
        @x_position = MIN_HORIZONTAL_POSITION
        set_horizontal_velocity 0
      elsif @x_position > MAX_HORIZONTAL_POSITION
        @x_position = MAX_HORIZONTAL_POSITION
        set_horizontal_velocity 0
      end

      if @y_position < MIN_VERTICAL_POSITION
        @y_position = MIN_VERTICAL_POSITION
        set_vertical_velocity 0
      elsif @y_position > MAX_VERTICAL_POSITION
        @y_position = MAX_VERTICAL_POSITION
        set_vertical_velocity 0
      end
    end

    def set_horizontal_velocity(new_h_velocity)
      v_velocity = self.velocity * Math.sin(self.direction)
      self.velocity = Math.sqrt(new_h_velocity*new_h_velocity + v_velocity*v_velocity)
      self.direction = Math.atan2(v_velocity, new_h_velocity)
    end

    def set_vertical_velocity(new_v_velocity)
      h_velocity = self.velocity * Math.cos(self.direction)
      self.velocity = Math.sqrt(h_velocity*h_velocity + new_v_velocity*new_v_velocity)
      self.direction = Math.atan2(new_v_velocity, h_velocity)
    end
end