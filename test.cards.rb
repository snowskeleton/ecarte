#!/bin/ruby
require_relative 'player.rb'
require_relative 'gather.rb'
require_relative 'cards.rb'
require_relative 'game.rb'
require_relative 'dealing.rb'



class Test

    def self.firstwins_bothtrump()
        card1 = Cards.deck.delete_at(0)
        card2 = Cards.deck.delete_at(0)
        result = Cards.winner(card2, card1)
        if result == card2 
            puts "test.cards firstwins_bothtrump | success"
        else
            puts "test.cards firstwins_bothtrump | fail"
        end
    end

    def self.secondwins_bothtrump()
        card1 = Cards.deck.delete_at(0)
        card2 = Cards.deck.delete_at(0)
        result = Cards.winner(card1, card2)
        if result == card2 
            puts "test.cards secondwins_bothtrump | success"
        else
            puts "test.cards secondwins_bothtrump | fail"
        end
    end

    def self.firstwins_notrump()
        card1 = Cards.deck.delete_at(-1)
        card2 = Cards.deck.delete_at(-1)
        result = Cards.winner(card1, card2)
        if result == card1
            puts "test.cards firstwins_notrump | success" 
        else
            puts "test.cards firstwins_notrump | fail"
        end
    end

    def self.secondwins_notrump()
        card1 = Cards.deck.delete_at(-1)
        card2 = Cards.deck.delete_at(-1)
        result = Cards.winner(card2, card1)
        if result == card1
            puts "test.cards secondwins_notrump | success" 
        else
            puts "test.cards secondwins_notrump | fail"
        end
    end

    def self.set_trump()
        maybetrump = Cards.deck.first
        Cards.set_trump()
        if maybetrump = Cards.trump
            puts "test.cards set_trump | success"
        else
            puts "test.cards set_trump | fail"
        end
    end
end

#prerecs
Gather.players(2)
Dealing.rotate()
Cards.newdeck()

#actual tests
Test.set_trump()
Test.firstwins_bothtrump()
Test.firstwins_notrump()
Test.secondwins_bothtrump()
Test.secondwins_notrump()
