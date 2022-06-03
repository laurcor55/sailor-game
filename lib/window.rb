require 'gosu'
require_relative './school_of_fish'
require_relative './input_control'
require_relative './waves'
require_relative './z_positions'


class Window < Gosu::Window

  def initialize(player, width: 640, height: 480)
    super width, height
    self.caption = 'Sailor Game'
    @player = player
    @waves = Waves.new
    @input = InputControl.new(self, @player)
    @fishies = SchoolOfFish.new(300, 200, ZPositions::SUBMERGED, player)
  end

  def update
    dt = delta_time
    @input.update(dt)
    @waves.update
    @player.update(dt) # update player
    @fishies.update(dt)
  end

  def draw
    @waves.draw
    @player.draw # draw player
    @fishies.draw
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