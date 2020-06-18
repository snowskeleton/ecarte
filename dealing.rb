#!/bin/ruby

class Dealing
        @@start = true

        def self.rotate()


                if @@start == false then
                        Player.list.rotate!(1)
                        print Player.list.last.name, + " is dealing next."
                else
                        @@start = false
                        dealer_count = rand(1..2)
                        Player.list.rotate!(dealer_count)
                        print Player.list.last.name, + " is dealing first."
                end
		Dealing.set_dealer()

                sleep(.1)
                puts #newline
                puts #newline
        end

	def self.set_dealer()
		Player.set_dealer(Player.list.first)
		Player.set_eldest_hand(Player.list.last)
	end
end

