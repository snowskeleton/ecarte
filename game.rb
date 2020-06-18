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
		while Player.eldest_hand.discard?()
			print "How many cards would you like to discard? "
			answer = gets.to_i
			if answer == 0
				
			end
			if Player.list.first.askcard?()
				Player.list.last.discard
			end
		end



end
