require_relative './lib/window'
require_relative './lib/player'

player = Player.new(200,200)
window = Window.new(player)

window.show