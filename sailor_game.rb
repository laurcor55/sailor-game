require_relative './lib/window'
require_relative './lib/player'
require_relative './lib/waves'

player = Player.new(200,200)
window = Window.new(player)

window.show