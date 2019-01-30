require_relative './lib/window'
require_relative './lib/player'

player = Player.new(300,300)
window = Window.new(player)

window.show