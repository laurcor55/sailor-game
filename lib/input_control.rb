require 'gosu'

class InputControl

  MOTION_MAGNITUDE = 0.0002


  def initialize(window_object, player_object)
    @player_object = player_object
    @window_object = window_object
  end

  def update(dt)
    handle_motion_keys(dt)
  end

  private

    def handle_motion_keys(dt)
      h = (Gosu.button_down?(Gosu::KB_LEFT) ? -1 : 0) + (Gosu.button_down?(Gosu::KB_RIGHT) ? 1 : 0)
      v = (Gosu.button_down?(Gosu::KB_UP) ? -1 : 0) + (Gosu.button_down?(Gosu::KB_DOWN) ? 1 : 0)
      return unless h*h + v*v > 0
      @player_object.accelerate(dt*MOTION_MAGNITUDE, Math.atan2(v,h))
    end
end