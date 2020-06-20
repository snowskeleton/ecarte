#!/bin/ruby
class Cards
	@@deck = []
	@@trump = ""

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

	attr_accessor :number, :suit, :value, :name

	def initialize(number, suit, value)
		@number = number
		@suit = suit
		@value = value
		@name = "#{number} of #{suit}"
	end

	def self.winner(leader_card, follower_card)
		if leader_card.suit != follower_card.suit && follower_card.suit != @@trump
			return leader_card
		else
			if leader_card.value > follower_card.value
				return leader_card
			elsif leader_card.value > follower_card.value
				return follower_card
			end
		end
	end

	def name()
		@name
	end
end
