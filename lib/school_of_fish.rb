require 'gosu'
require_relative './player'

class SchoolOfFish
  IMAGE_WIDTH = 50
  IMAGE_HEIGHT = 50

  def initialize(x, y, z, player)
    @x_position = x
    @y_position = y
    @z_position = z
    
    set_base_parameters

    @rotation_speed = Math::PI / 50
    @rotation = 0

    @player = player
    
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

    update_dispersing(dt)
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

    def update_dispersing(dt)
      if (@dispersing)
        density_change(dt, 0.001)
        size_change(dt, -0.001)
        alpha_change(dt, -0.001)
        blue_change(dt, -0.255)
        check_if_done_dispersing
      elsif (@regrouping)
        density_change(dt, -0.001)
        size_change(dt, 0.001)
        alpha_change(dt, 0.001)
        blue_change(dt, 0.255)
        check_if_done_regrouping
      else
        distance = check_distance_to(@player)
        @dispersing = distance < 100
      end
    end
    
    def check_distance_to(object)
      distance = Math.sqrt((object.y_position-@y_position)**2 + (object.x_position-@x_position)**2)
      distance
    end

    def size_change(dt, rate)
      @school_size += dt*(rate.to_f)*@school_size
    end

    def density_change(dt, rate)
      @school_density += dt*(rate.to_f)*@school_density
    end

    def alpha_change(dt, rate)
      @color_a += dt*(rate.to_f)*@color_a
    end

    def blue_change(dt, rate)
      @color_b += dt*(rate.to_f)*@color_b
    end

    def set_base_parameters
      @x_fish_speed = 0.1
      @y_fish_speed = 0.1

      @school_density = 0.5
      @school_size = 1
  
      @color_a = 128
      @color_r = 0
      @color_g = 0
      @color_b = 0
    end

    def check_if_done_dispersing
      if (@school_size<0.1)
        @dispersing = false
        @regrouping = true
      end
    end

    def check_if_done_regrouping
      if (@school_size>1)
        @regrouping = false
        @dispersing = false
        set_base_parameters
      end
    end


end