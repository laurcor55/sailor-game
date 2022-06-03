class Player
  MIN_HORIZONTAL_POSITION = 20
  MAX_HORIZONTAL_POSITION = 625
  MIN_VERTICAL_POSITION = 20
  MAX_VERTICAL_POSITION = 460

  IMAGE_WIDTH = 70
  IMAGE_HEIGHT = 50

  attr_accessor :velocity, :direction
  attr_reader :x_position, :y_position

  def initialize(x, y, z)
    @x_position = x # store the horizontal
    @y_position = y # and vertical positions
    @z_position = z # and z

    self.velocity = 0 # velocity stored in polar magnitude
    self.direction = 0 # and angle

    @image_tiles = Gosu::Image.load_tiles('media/player.png', 829, 529)
    @number_tiles = @image_tiles.length

    @oar_angle = [0, 0, 0]

    @vertical_scale = IMAGE_HEIGHT.to_f / @image_tiles[1].height
    @horizontal_scale = IMAGE_WIDTH.to_f / @image_tiles[1].width
 
    @font = Gosu::Font.new(20) # for debugging
  end

  def accelerate(magnitude, direction)
    delta_h_velocity = magnitude * Math.cos(direction) # acceleration applies a horizontal
    delta_v_velocity = magnitude * Math.sin(direction) # and vertical change in velocity

    h_velocity = self.velocity * Math.cos(self.direction) + delta_h_velocity
    v_velocity = self.velocity * Math.sin(self.direction) + delta_v_velocity

    self.velocity = Math.sqrt(h_velocity*h_velocity + v_velocity*v_velocity)
    set_direction(h_velocity, v_velocity)

    move_oars
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
    @image_tiles.each.with_index do |tile, tile_index|
      tile.draw_rot(
        @x_position,
        @y_position,
        @z_position-tile_index%2,
        self.direction*180/Math::PI + (tile_index%2-1)*@oar_angle[tile_index],
        0.5,1-0.5*tile_index,
        @horizontal_scale,
        @vertical_scale,
      )
    end

    @font.draw_text("velocity: #{self.velocity}\ndirection: #{self.direction}", 0, 0, 0)
  end

  private
    def move_oars
      @oar_angle[0] = 15 * Math.sin(Gosu::milliseconds()/100) + 15
      @oar_angle[2] = -(15 * Math.sin(Gosu::milliseconds()/100) + 15)
    end

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
      set_direction(new_h_velocity, v_velocity)
    end

    def set_vertical_velocity(new_v_velocity)
      h_velocity = self.velocity * Math.cos(self.direction)
      self.velocity = Math.sqrt(h_velocity*h_velocity + new_v_velocity*new_v_velocity)
      set_direction(h_velocity, new_v_velocity)
    end

    def set_direction(h_velocity, v_velocity)
      self.direction = Math.atan2(v_velocity, h_velocity)
    end
end