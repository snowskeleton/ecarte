#!/bin/ruby

class Game
 	def self.keep_going?()
                if (Player.list.first.score >= 10 || Player.list.last.score >= 10)
                        return false
                else
                        return true
                end
        end

	def self.change_cards()
		Player.dealer.set_vulnerable=(true)
		Player.eldest_hand.set_vulnerable=(true)
		first = true
		while Player.eldest_hand.discard?()
			Player.eldest_hand.set_vulnerable=(false)

			print "How many cards would you, #{Player.eldest_hand.name}, like to discard? "
			answer = gets.to_i
			#this could be a method
			if answer > Cards.deck.count
				puts "There aren't enough cards for that. Choose a different number, please.\n"
				redo
			end
			#
			if Player.dealer.permission?(answer)
				first = false
				Player.dealer.set_vulnerable=(false)
				Player.eldest_hand.redraw(answer)
				Player.dealer.redraw(nil)
			elsif first == true
				Player.dealer.set_vulnerable=(true)
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
	end
end
