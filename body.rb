require "gosu"
require_relative "z_order"

class Body

	# arrrays for each body

	def initialize(file)
		@file = file
		@x = []
		@y = []
		@x_vel = []
		@y_vel = []
		@mass = []
		@image = []

		File.open(file).each_with_index do |line, i|
			info = line.split(" ")
			if i == 0
				@planets = info[0].to_i
			elsif i == 1
				@radius = info[0]
			elsif i > 1
				@x.push(info[0].strip)
				@y.push(info[1].strip)
				@x_vel.push(info[2].strip)
				@y_vel.push(info[3].strip)
				@mass.push(info[4].strip)
				@image.push(info[5].strip)
			end
		end
	end

	def return
		return @x, @y, @x_vel, @y_vel, @mass, @image, @planets, @radius
	end

end
