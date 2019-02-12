require_relative './player'

class SchoolOfFish
  IMAGE_WIDTH = 50
  IMAGE_HEIGHT = 50

  def initialize(x, y, z, player)
    @x_position = x
    @y_position = y
    @z_position = z

    @x_fish_speed = 0.1
    @y_fish_speed = 0.1
    @school_density = 0.5
    @school_size = 1

    @color_a = 128
    @color_r = 0
    @color_g = 0
    @color_b = 0

    @player = player

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

    if(@dispersing)
      decrease_density(dt)
      shrink(dt)
      fade_out(dt)
      bluer(dt) 
      done_dispersing
    end
    
    @x_position += @x_fish_speed
    @y_position += @y_fish_speed
    @rotation += dt*@rotation_speed
  end

  def disperse
    @dispersing = true
  end

  def draw
    
    color = (
      @color_a.floor * (2**(3*8)) +
      @color_r.floor * (2**(2*8)) +
      @color_g.floor * (2**(1*8)) +
      @color_b.floor * (2**(0*8))
    )

    @image_tiles.each.with_index do |tile, tile_index|
      tile.draw_rot(
        @x_position,
        @y_position,
        @z_position,
        (tile_index % 2 == 0 ? @rotation : -1 * @rotation) / (1 + tile_index),
        @school_density,@school_density,@school_size,@school_size,
        color
      )
    end
  end

  private

  def shrink(dt)
    @school_size += -dt*(1/10000.to_f)
  end

  def decrease_density(dt)
    @school_density += -dt*(0.5/700.to_f)
  end

  def fade_out(dt)
    if (@color_a > 0)
      @color_a = @color_a - dt*(255/2000.to_f)
    end
  end

  def bluer(dt)
    if (@color_b < 255)
      @color_b = @color_b + dt*(255/500.to_f)
    end
    
  end

  def done_dispersing
    if (@color_b > 255)
      @color_b = 255
    end
    if (@color_a < 0)
      @color_a = 0
    end
    if (@color_a==0 && @color_b==255)
      @dispersing = false
      @school_density = 0.5
    end
  end

end