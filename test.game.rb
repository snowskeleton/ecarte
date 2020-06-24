#!/bin/ruby
require_relative 'player.rb'
require_relative 'gather.rb'
require_relative 'cards.rb'
require_relative 'game.rb'
require_relative 'dealing.rb'


class Test

    def self.input_number()
        var1 = 3
        tvar1 = Game.input_number("enter '3': ", 5)

        if var1 == tvar1
            puts "success"
        else
            puts "fail"
        end
    end


end

Test.input_number()
