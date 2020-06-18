#!/bin/ruby

class Player
	@@list = []
	@@dealer
	@@eldest_hand
	attr_accessor :name, :score, :hand, :vulnerable

	def self.list
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

	def initialize(name)
		@name = name
		@vulnerable = false
		@score = 0
		@hand = []
		@@list.push(self)
	end

	def vulnerable?()
		@vulnerable
	end
end
