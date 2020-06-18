#!/bin/ruby
class Cards
	@@trump = ""
	attr_accessor :number, :suit, :value, :name
	def initialize(number, suit, value)
		@number = number
		@suit = suit
		@value = value
		@name = "#{number} of #{suit}"
	end

	def self.winner(card1, card2)
		if card1.suit != card2.suit && card2.suit != @@trump
			return card1
		else
			if card1.value > card2.value
				return card1
			elsif card1.value > card2.value
				return card2
			end
		end
	end

	def name()
		@name
	end
end
