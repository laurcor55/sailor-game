class Waves
  def initialize
    @wave1_image = Gosu::Image.new('media/wave1.png')
    @wave2_image = Gosu::Image.new('media/wave2.png')
    @wave3_image = Gosu::Image.new('media/wave3.png')

  end

  # apply velocity to the position
  def update
    current_time = Gosu::milliseconds()
    @wave_offset_fast = 30*Math.sin(current_time*0.0006)
    @wave_offset_slow = 25*Math.sin(current_time*0.0005)
  end

  def draw
    jj=0
    loop do
      wave_size = 0.2
      y_offset = 10
      y_position_wave = jj*y_offset*7
      
      
      @wave1_image.draw(
        @wave_offset_fast-37,
        y_position_wave,
        0,
        wave_size, wave_size
      )
      @wave2_image.draw(
        -3,
        y_position_wave+y_offset,
        0,
        wave_size, wave_size
      )
      @wave3_image.draw(
        -@wave_offset_slow-17,
        y_position_wave+y_offset*2,
        0,
        wave_size, wave_size
      )
      @wave2_image.draw(
        -25,
        y_position_wave+y_offset*3,
        0,
        wave_size, wave_size
      )
      @wave3_image.draw(
        0,
        y_position_wave+y_offset*4,
        0,
        wave_size, wave_size
      )
      @wave2_image.draw(
        -34,
        y_position_wave+y_offset*5,
        0,
        wave_size, wave_size
      )
      @wave3_image.draw(
        -15,
        y_position_wave+y_offset*6,
        0,
        wave_size, wave_size
      )
      
      if jj==25
        break
      end
      jj+=1
    end
  end
end

