#!/bin/ruby

class Game

    def self.yesno?(question)
        1.times do
            print question
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

 	def self.keep_going?()
        if (Player.list.first.score >= 5 || Player.list.last.score >= 5)
            return false
        else
            return true
        end
    end

    def self.input_number(string)
        1.times do
            print string
            input = gets.to_i
            puts input
            #puts "class.game | def.self.input_number"
            input if Integer(input) rescue redo
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

            Player.dealer.show_hand()
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
                    if Game.yesno?("Do you wish to reveal the King of trumps?(Y/n) ")
                        puts "#{player.name} reveals the #{card.name}\n\n"
                        player.score += 1
                    end
                end
            end
        end
	end
end
