require 'gosu'

class SchoolOfFish
  IMAGE_WIDTH = 50
  IMAGE_HEIGHT = 50

  def initialize(x, y)
    @x_position = x
    @y_position = y
    @z_position = 0

    @rotation_speed = Math::PI / 50
    @rotation = 0

    @image_tiles = Gosu::Image.load_tiles('media/school.png', 50, 50)
    @number_tiles = @image_tiles.length
  end

  def update(dt)
    @x_position += 0.3*rand-0.3 
    @y_position += 0.3*rand-0.3
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