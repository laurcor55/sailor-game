require 'gosu'

class SchoolOfFish
  IMAGE_WIDTH = 50
  IMAGE_HEIGHT = 50

  def initialize(x, y, z)
    @x_position = x
    @y_position = y
    @z_position = z
    @x_fish_speed = 0.1
    @y_fish_speed = 0.1

    @rotation_speed = Math::PI / 50
    @rotation = 0

    @image_tiles = Gosu::Image.load_tiles('media/school.png', 500, 155)
    @number_tiles = @image_tiles.length
    p @number_tiles
  end

  def update(dt)
    @x_position += Math::cos(Gosu::milliseconds()/2000)
    @y_position += Math::sin(Gosu::milliseconds()/2000*0.7)
    @rotation += dt*@rotation_speed
  end

  def draw
    @image
    @image_tiles.each.with_index do |tile, tile_index|
      tile.draw_rot(
        @x_position+Math::cos(Gosu::milliseconds()/2000*(tile_index+1)),
        @y_position+Math::cos(Gosu::milliseconds()/2000*(tile_index+3)),
        @z_position,
        (tile_index % 2 == 0 ? @rotation : -1 * @rotation) / (1 + tile_index),
        0.5,0.5,0.1,0.1,
        0x90_000000
      )
    end
  end

end