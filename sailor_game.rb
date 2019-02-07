require_relative './lib/window'
require_relative './lib/player'
require_relative './lib/z_positions'


player = Player.new(200,200, ZPositions::FLOATING)
window = Window.new(player)

window.show