require 'gosu'

class SchoolOfFish
  IMAGE_WIDTH = 50
  IMAGE_HEIGHT = 50

  def initialize(x, y)
    @x_position = x
    @y_position = y
    @z_position = 0
    @x_fish_speed = 0.1
    @y_fish_speed = 0.1

    @rotation_speed = Math::PI / 50
    @rotation = 0

    @image_tiles = Gosu::Image.load_tiles('media/school.png', 50, 50)
    @number_tiles = @image_tiles.length
  end

  def update(dt)
    if (rand<0.01)
      @x_fish_speed = 1*rand-0.5
    elsif (rand<0.01)
      @y_fish_speed = 1*rand-0.5
    end
    @x_position += @x_fish_speed
    @y_position += @y_fish_speed
    @rotation += dt*@rotation_speed
  end

  def draw
    @image_tiles.each.with_index do |tile, tile_index|
      tile.draw_rot(
        @x_position,
        @y_position,
        @z_position,
        (tile_index % 2 == 0 ? @rotation : -1 * @rotation) / (1 + tile_index),
        0.5,0.5,1,1,
        0x88_00ffff
      )
    end
  end

end