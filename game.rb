#!/bin/ruby

class Game
 	def self.keep_going?()
        if (Player.list.first.score >= 5 || Player.list.last.score >= 5)
            return false
        else
            return true
        end
    end

    def self.input_number(string)
        1.times do
            if string != nil 
                print string
            end
            input = gets.chomp
            input if Float(input) rescue redo
        end
    end

	def self.change_cards()
		Player.dealer.set_vulnerable=(false)
		Player.eldest_hand.set_vulnerable=(true)
		first = true

		while Player.eldest_hand.discard?()
			Player.eldest_hand.set_vulnerable=(false)

            answer  = Game.input_number("How many cards would you, #{Player.eldest_hand.name}, like to discard? ")
            puts

			#this could be a method
			if answer > Cards.deck.count
				puts "There aren't enough cards for that. Choose a different number, please.\n"
				redo
			end
			#

            Player.dealer.hand
            puts
			if Player.dealer.permission?(answer)
				first = false
				Player.eldest_hand.redraw(answer)
				Player.dealer.redraw(nil)
			else
				if first == true
					Player.dealer.set_vulnerable=(true)
				end
				break
			end
		end
		puts
		if Player.dealer.vulnerable?()
			puts "#{Player.dealer.name} is vulnerable.\n"
		end
		if Player.eldest_hand.vulnerable?()
			puts "#{Player.eldest_hand.name} is vulnerable.\n"
		end
		puts

        Player.list.each do |player|
            player.hand.each do |card|
                if card.number == "King" && card.suit == Cards.trump.suit
                    puts "Do you wish to reveal the King of trumps?(Y/n)"
                    answer = gets.chomp
                    if answer == "y"
                        puts card.name
                        player.score += 1
                    end
                end
            end
        end
	end

    def self.declare_score()
                Player.dealer.tricks > Player.follower.tricks ? winner = Player.dealer : winner = Player.eldest_hand
                puts "#{winner.name} got #{winner.tricks}!"
    end

end
