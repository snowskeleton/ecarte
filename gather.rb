#!/bin/ruby

class Gather
	def self.players(number)
               	num = 1

               	number.times {
                       	print "Who is player " + num.to_s + "? "
                       	player = gets.chomp.to_s
                       	player = Player.new(player)
                       	num += 1
               	}
               	puts #newline
	end
end
