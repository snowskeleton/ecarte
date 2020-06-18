#!/bin/ruby

class Player
	@@list = []
	@@dealer
	@@eldest_hand
	attr_accessor :name, :score, :hand, :vulnerable

	def self.list
		@@list
	end

	def self.set_dealer(player)
		@@dealer = player
	end

	def self.dealer()
		@@dealer
	end

	def self.set_eldest_hand(player)
		@@eldest_hand = player
	end

	def self.eldest_hand()
		@@eldest_hand
	end

	def initialize(name)
		@name = name
		@vulnerable = false
		@score = 0
		@hand = []
		@@list.push(self)
	end

	def set_vulnerable=(bool)
		@vulnerable = bool
	end

	def vulnerable?()
		@vulnerable
	end

	def hand()
		@hand
	end

	def draw(number)
		number.times do
			#print @hand
			#print "   << this should be the player's hand\n"
			@hand.push(Deck.deck.delete_at(1))
		end
	end

	def discard?()
		1.times do
			print "Would you like to discard and redraw? "
			answer = gets.chomp
			case answer
			when "yes", "ye", "y", "eys"
				return true
			when "no", "on", "n"
				return false
			else
				puts "Input not recognized.\n"
				redo
			end
		end
	end

	def redraw(number)
		if number == nil
			print "How many cards would you like to redraw? "
			number = gets.to_i
			puts
		end

		i = 0
		number.times do
			j = 0
			@hand.each do |card|
				print j.to_s, + ". ", + @hand[j].name
				j += 1
				puts
			end
			puts
			print "Which card would you like to discard?(#{i}/#{number}) "
			card = gets.to_i
			puts "\nDiscarding #{@hand.delete_at(card).name}\n"
			sleep(0.5)
			puts
			i += 1
		end
		puts
		self.draw(number)
	end

	def permission?(number)
		1.times do
			print "Will you allow your opponent to discard #{number} cards? "
			answer = gets.chomp
			puts
			case answer
			when "yes", "ye", "y", "eys"
				return true
			when "no", "on", "n"
				return false
			else
				puts "Input not recognized. Please provide an acceptable answer.\n"
				redo
			end
		end
	end
end
