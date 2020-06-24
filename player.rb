#!/bin/ruby

class Player
    @@list = []
    @@dealer
    @@eldest_hand
    @@leader
    @@follower
    @@winner
    @@loser

    def self.winner=(player)
        @@winner = player
    end

    def self.loser=(player)
        @@loser = player
    end

    def self.leader()
        @@leader
    end

    def self.follower()
        @@follower
    end

    def self.list()
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

    def self.draw()
        self.list.each do |player|
            player.draw()
        end
    end

    def self.score()
        Player.list.each do |player|
            puts "#{player.name} is at #{player.score}"
        end
    end

    def self.play()
        Player.list.each do |player|
            player.tricks = 0
        end

        tricks = 1
        @@leader = @@eldest_hand
        @@follower = @@dealer

        until tricks == 6
            puts "#{@@leader.name} leads.\n\n"
            leader_card = @@leader.lead()
            follower_card = @@follower.follow(leader_card)
            winner = Cards.winner(leader_card, follower_card)

            if leader_card != winner
                puts "#{@@follower.name} won.\n"
                @@follower.tricks += 1

                temp = @@leader
                @@leader = @@follower
                @@follower = temp
            else
                puts "#{@@leader.name} won.\n"
                @@leader.tricks += 1
            end

            tricks += 1
        end
    end

    def self.declare_score()
        if @@dealer.tricks > @@eldest_hand.tricks 
            @@winner = @@dealer and @@loser = @@eldest_hand 
        else
            @@winner = @@eldest_hand and @@loser = @@dealer
        end
        puts "#{@@winner.name} got #{@@winner.tricks}!"

        @@winner.score += 1

        if @@loser.vulnerable?
            @@winner.score += 1
        end

        if @@winner.tricks == 5
            @@winner.score += 1
        end
            
        Player.score
    end

    attr_accessor :name, :score, :hand, :vulnerable, :tricks

    def initialize(name)
        @name = name
        @vulnerable = false
        @score = 0
        @tricks = 0
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

    def show_hand()
        puts "#{self.name}'s hand\n"
        number = 1
        @hand.each do |card|
            puts "#{number}. #{@hand[number - 1].name}"
            number += 1
        end
        puts
    end

    def draw()
        until @hand.count == 5 do
            @hand.push(Cards.deck.delete_at(0))
        end
    end

    def pick_card()
        self.show_hand
        1.times do
            card = Game.input_number("Pick a card: ", self.hand.count)
            if card > @hand.count
                redo
            end
            puts
            return @hand.delete_at(card - 1) # the +1 is because the array starts at 0
        end
    end

    def lead()
        card = self.pick_card()
        puts "\Playing #{card.name}\n\n"
        sleep(1)
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
            follower_card = self.pick_card()
            puts "\Playing #{follower_card.name}\n\n"

            if force_follow_suit && follower_card.suit != leader_card.suit
                puts "Please follow suit."
                @hand.push(follower_card)
                puts
                sleep(1)
                redo
            end
            sleep(1)
            return follower_card
        end
    end

    def discard?()
        self.show_hand()
        return Game.yesno?("Would you like to discard and redraw? ")
    end

    def redraw(number)
        1.times do
            if number == nil
                self.show_hand()
                number = Game.input_number("How many cards would you like to redraw? ", self.hand.count)
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
                card = self.pick_card()
                puts "Discarding #{card.name}\n"
                puts
                sleep(1)
                i += 1
            end
        end
        self.draw()
    end

    def permission?(number)
        return Game.yesno?("Will you allow your opponent to discard #{number} cards? ")
    end
end
