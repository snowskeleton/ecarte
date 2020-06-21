#!/bin/ruby
require_relative 'player.rb'
require_relative 'gather.rb'
require_relative 'cards.rb'
require_relative 'game.rb'
require_relative 'dealing.rb'



system("clear")
Gather.players(2)
while Game.keep_going?()
	Dealing.rotate()
	Cards.newdeck()
	Cards.shuffle()
	Player.new_hand()
    Cards.set_trump()
	Game.change_cards()
	Player.play()
    Player.declare_score()
end
