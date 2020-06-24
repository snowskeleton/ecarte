#!/bin/ruby

class Game

    def self.yesno?(question)
        1.times do
            print question
            answer = gets.chomp
            case answer
            when "yes", "ye", "y", "eys", "yse"
                puts
                return true
            when "no", "on", "n", "non"
                puts
                return false
            else
                puts
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

    def self.input_number(string, max_num)
        1.times do
            print string
            input = gets.chomp
            if input =~ /^-?[0-9]+$/ && input.to_i <= max_num.to_i
                return input.to_i
            else
                puts "No card in that range. Please try again."
                redo
            end
        end
    end

	def self.change_cards()
		Player.dealer.set_vulnerable=(false)
		Player.eldest_hand.set_vulnerable=(true)
		first = true

		while Player.eldest_hand.discard?()
			Player.eldest_hand.set_vulnerable=(false)

            answer  = Game.input_number("How many cards would you, #{Player.eldest_hand.name}, like to discard? ", Player.eldest_hand.hand.count)
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
				Player.dealer.set_vulnerable=(true) if first == true
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
