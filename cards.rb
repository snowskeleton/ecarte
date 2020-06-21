#!/bin/ruby
class Cards
	@@deck = []
	@@trump = nil

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

    def self.set_trump()
            @@trump = @@deck.delete_at(1)
            puts "#{Player.dealer.name} flips over a #{@@trump.name}.\n\n"
            if @@trump.number == "King" && Player.dealer.score < 4
                Player.dealer.score += 1
            end
    end

    def self.trump()
        @@trump
    end

	attr_accessor :number, :suit, :value, :name

	def initialize(number, suit, value)
		@number = number
		@suit = suit
		@value = value
		@name = "#{number} of #{suit}"
	end

	def self.winner(leader_card, follower_card)
		if leader_card.suit != follower_card.suit && follower_card.suit != @@trump.suit
			return leader_card
        end
		if leader_card.value > follower_card.value
			return leader_card
        end
		return follower_card
	end

	def name()
		@name
	end
end
