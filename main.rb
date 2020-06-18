#!/bin/ruby
require_relative 'player.rb'
require_relative 'deck.rb'
require_relative 'gather.rb'
require_relative 'cards.rb'
require_relative 'game.rb'
require_relative 'dealing.rb'



Gather.players(2)
while Game.keep_going?()
	Dealing.rotate()
	Deck.newdeck()
	Deck.shuffle()
	Player.list.each do |player|
		player.draw(5)
	end
	Game.change_cards()
end
