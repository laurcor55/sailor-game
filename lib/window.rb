require 'gosu'
require_relative './input_control'
require_relative './waves'


class Window < Gosu::Window
  def initialize(player, width: 640, height: 480)
    super width, height
    self.caption = 'Sailor Game'
    @player = player
    @waves = Waves.new
    @input = InputControl.new(@player)
  end

  def update
    dt = delta_time
    @input.update(dt)
    @waves.update
    @player.update(dt) # update player
  end

  def draw
    @waves.draw
    @player.draw # draw player
  end

  private
    def delta_time
      @last_elapsed ||= Gosu::milliseconds()
      elapsed = Gosu::milliseconds()
      dt = elapsed - @last_elapsed
      @last_elapsed = elapsed
      dt = 0 if dt < 0 # Gosu::milliseconds() doesn't handle max numeric values so eventually just starts back at zero
      dt
    end
end