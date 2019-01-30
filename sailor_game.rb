require_relative './lib/window'
require_relative './lib/player'


#Game window
class SailorGame < Gosu::Window
  def initialize(width: 600, height:400)
    super width, height
    @input = UserInput.new
    @background = Background.new
    @ship = Ship.new(300, 200)

  #  @ship.accelerate(1, 1)
  end

  
  def update
    user_input = @input.update
    @background.update
    @ship.update(user_input)
  end
  
  def draw
    @background.draw
    @ship.draw
  end
end

class UserInput
  def initialize
    return "\0"
  end

  def update
    if Gosu.button_down? Gosu::KbDown
      return "down"
    elsif Gosu.button_down? Gosu::KbUp
      return "up"
    elsif Gosu.button_down? Gosu::KbLeft
      return "left"
    elsif Gosu.button_down? Gosu::KbRight
      return "right"
    elsif Gosu.button_down? Gosu::KbSpace
      return "speed"
    else
      return "\0"
    end
  end
end

class Ship
  def initialize(x, y)
    @x_position = x 
    @y_position = y 
    @velocity = 0
    @direction = 0

    @ship_image = Gosu::Image.new('pirate_doodle.png')
  end

  

  def update(user_input)
    @x_position += @velocity * Math.cos(@direction) #Equation for horizontal velocity
    @y_position += @velocity * Math.sin(@direction) #Equation for vertical velocity

    if user_input=="down"
      if (@direction%(2*Math::PI))<Math::PI/2 || (@direction%(2*Math::PI))>3*Math::PI/2
        @direction+= 0.1
      else
        @direction+= -0.1
      end
    elsif user_input=="up"
      if (@direction%(2*Math::PI))<Math::PI/2 || (@direction%(2*Math::PI))>3*Math::PI/2
        @direction+= -0.1
      else
        @direction+= 0.1
      end
    elsif user_input=="left"
      @direction+= -0.11
    elsif user_input=="right"
      @direction+= 0.1
    elsif user_input=="speed"
      @velocity += 0.05
    end
  end



  def draw
    @ship_image.draw_rot(
      @x_position,
      @y_position,
      0,
      @direction*180/Math::PI+180,
      0.5, 0.5,
      0.05, 0.05
    )
  end
end

class Background
  def initialize
    @iteration = 1
    @wave1_image = Gosu::Image.new('wave1.png')
    @wave2_image = Gosu::Image.new('wave2.png')
    @wave3_image = Gosu::Image.new('wave3.png')
  end

  def update
    @iteration += 1
    if (@iteration%50<25)
      @wave_offset=1
    else
      @wave_offset=0
    end
  end

  def draw
    jj=0
    loop do
      y_position_wave = jj*20
      
      @wave1_image.draw(
        @wave_offset*5-10,
        y_position_wave,
        0,
        0.10, 0.10
      )
      @wave2_image.draw(
        0,
        y_position_wave+5,
        0,
        0.10, 0.10
      )
      @wave3_image.draw(
        -@wave_offset*6,
        y_position_wave+10,
        0,
        0.10, 0.10
      )
      @wave2_image.draw(
        0,
        y_position_wave+15,
        0,
        0.10, 0.10
      )
      
      if jj==20
        break
      end
      jj+=1
    end
    
  end
end

game = SailorGame.new
game.show