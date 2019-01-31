require_relative './lib/window'
require_relative './lib/player'

player = Player.new(640, 480)
window = Window.new(player)

window.show