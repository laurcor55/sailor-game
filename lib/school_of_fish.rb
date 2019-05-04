require 'gosu'

class SchoolOfFish
  IMAGE_WIDTH = 50
  IMAGE_HEIGHT = 50

  def initialize(x, y, z)
    @fish_per_school = 10
    @x_position = Array.new(@fish_per_school){|index| x}
    @y_position = Array.new(@fish_per_school){|index| y}
    @x_velocity = Array.new(@fish_per_school)
    @y_velocity = Array.new(@fish_per_school)
    @period = Array.new(@fish_per_school)
    @z_position = z
  

    @direction = Array.new(@fish_per_school){|index| 0}
    determine_target
    determine_velocity(17)
    determine_period

    Random.new_seed

    @image_tiles = Gosu::Image.load_tiles('media/school.png', 50, 15)
    @number_tiles = @image_tiles.length
  end

  def update(dt)
    if (Gosu::milliseconds()%5000<10)
      determine_target
      determine_velocity(dt)
      determine_period
    end
    y_bound = Math::sin(2*Math::PI*Gosu::milliseconds()/20000)
    y_offset = Array.new(@fish_per_school)
    x_offset = Array.new(@fish_per_school)

    y_offset.each.with_index do |array, index|
      y_offset[index] = 0.5*Math::cos(2*Math::PI*Gosu::milliseconds()/(@period[index]))#*y_bound
      x_offset[index] = 0.5*Math::sin(2*Math::PI*Gosu::milliseconds()/(@period[index]))#*x_bound
      
      @x_position[index] += @x_velocity[index] + x_offset[index]
      @y_position[index] += @y_velocity[index] + y_offset[index]
      ideal_angle = Math::atan((@y_velocity[index]+y_offset[index])/(@x_velocity[index]+x_offset[index]))*180/Math::PI
      ideal_angle += 2*Math::PI
      ideal_angle = ideal_angle.to_f
      if (ideal_angle<@direction[index]-0.05)
        @direction[index] += 0.5
      elsif (ideal_angle>@direction[index]-0.05)
        @direction[index] += -0.5
      end
    end
  end

  def determine_target
    @target_x_position = rand(0..640)
    @target_y_position = 100 #rand(0..480)
    p @target_x_position, @target_y_position
  end

  def determine_period
    @period.each.with_index do |array, index|
      @period[index] = rand(1000..10000)
    end
  end

  def determine_velocity(dt)
    @x_velocity.each.with_index do |array, index|
      @x_velocity[index] = (@target_x_position-@x_position[index]).to_f*dt/10000
      @y_velocity[index] = (@target_y_position - @y_position[index]).to_f*dt/10000
    end
  end
  
  def draw
    indeces = Array.new(@fish_per_school) {|index| index}
    indeces.each.with_index do |index|
      tile_index = indeces[index] % 2
      single_fish = @image_tiles[tile_index]
      single_fish.draw_rot(
        @x_position[index],
        @y_position[index],
        @z_position,
        @direction[index],
        0.5,0.5,0.75,0.75,
        0x50_000000
      )
    end
  end

end