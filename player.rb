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

	def self.new_hand()
		self.list.each do |player|
			player.draw(5)
		end
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
		j = 0
		@hand.each do |card|
			print j.to_s, + ". ", + @hand[j].name
			j += 1
			puts
		end
	end

	def draw(number)
		number.times do
			@hand.push(Cards.deck.delete_at(1))
		end
	end

	def pick_card()
		1.times do
			card = gets.to_i
			if card > @hand.count - 1
				print "\nHurr durr, that's not a card. Try again.\n\nCard? "
				redo
			end
			return card
		end
	end

	def self.play()
		tricks = 1
		leader = @@eldest_hand
		follower = @@dealer

		until tricks == 6
			puts "#{leader.name} leads.\n\n"
			leader_card = leader.play()
			follower_card = follower.follow(leader_card)
			winner = Cards.winner(leader_card, follower_card)

			if leader_card != winner
				puts "#{follower.name} won.\n"
				temp = leader
				leader = follower
				follower = temp
			else
				puts "#{leader.name} won.\n"
			end

			tricks += 1
		end
	end

	def play()
		self.hand
		puts

		print "Which card would you like to play? "
		card = self.pick_card()
		puts

		puts "\Playing #{@hand[card].name}\n"
		card = @hand.delete_at(card)
		puts

		sleep(0.5)
		return card
	end

	def follow(leader_card)
		force_follow_suit = false
		@hand.each do |card|
			if card.suit == leader_card.suit
				force_follow_suit = true
			end
		end
		1.times do
			self.hand
			puts

			print "Which card would you like to play? "
			card = self.pick_card()
			puts

			if force_follow_suit && @hand[card].suit != leader_card.suit
				puts "cards don't match"
				puts
				sleep(0.5)
				redo
			end

			puts "\Playing #{@hand[card].name}\n"
			card = @hand.delete_at(card)
			puts

			sleep(0.5)
			return card
		end
	end

	def discard?()
		1.times do
			print "Would you like to discard and redraw? "
			answer = gets.chomp
			case answer
			when "yes", "ye", "y", "eys"
				return true
			when "no", "on", "n", "non"
				return false
			else
				puts "Input not recognized.\n"
				redo
			end
		end
	end

	def redraw(number)
		1.times do
			if number == nil
				print "How many cards would you like to redraw? "
				number = gets.to_i
				puts
			end

			if number > Cards.deck.count
				puts "There aren't enough cards for that. Choose a different number, please.\n"
				number = nil
				redo
			end
		end

		i = 0
		number.times do
			1.times do
				self.hand
				puts
				print "Which card would you like to discard?(#{i}/#{number}) "
				card = self.pick_card()
				puts "\nDiscarding #{@hand.delete_at(card).name}\n"
				sleep(0.5)
				puts
				i += 1
			end
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
