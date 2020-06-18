#!/bin/ruby

class Deck
	@@deck = []
	def self.newdeck()
		["Clubs", "Hearts", "Spades", "Diamonds"].each do |suit|
			value = 1
			["7", "8", "9", "10", "Ace", "Jack", "Queen", "King"].each do |number|
				@@deck.push(Cards.new(number, suit, value))
				value += 1
			end
		end
	end

	def self.shuffle()
		@@deck.shuffle!
	end

	def self.showdeck()
		@@deck.each do |card|
			p card
		end
	end

	def self.deck()
		@@deck
	end
end

