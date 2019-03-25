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
    

    @target_x_position = 500
    @target_y_position = 100

    @direction = Array.new(@fish_per_school){|index| 0}
    determine_velocity(17)
    determine_period

    @image_tiles = Gosu::Image.load_tiles('media/school.png', 50, 15)
    @number_tiles = @image_tiles.length
  end

  def update(dt)
    if (Gosu::milliseconds()%10000==0)
      determine_velocity(dt)
      determine_period
    end
    y_bound = Math::sin(2*Math::PI*Gosu::milliseconds()/20000)
    y_offset = Array.new(@fish_per_school)
    y_offset.each.with_index do |array, index|
      y_offset[index] = 0.5*Math::cos(2*Math::PI*Gosu::milliseconds()/(@period[index]))#*y_bound
      @x_position[index] += @x_velocity[index]
      @y_position[index] += @y_velocity[index] + y_offset[index]
      @direction[index] = Math::atan((@y_velocity[index]+y_offset[index])/@x_velocity[index])*180/Math::PI
    end
  end

  def determine_period
    @period.each.with_index do |array, index|
      @period[index] = rand(1000..10000)
    end
    
  end

  def determine_velocity(dt)
    @x_velocity.each.with_index do |array, index|
      @x_velocity[index] = (@x_position[index]-@target_x_position)*dt/10000
      @y_velocity[index] = (@y_position[index]-@target_y_position)*dt/10000
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