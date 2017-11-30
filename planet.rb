class Planet

	def initialize(x, y, x_vel, y_vel, mass, image, radius)
		@x = x.to_f
		@y = y.to_f
		@x_vel = x_vel.to_f
		@y_vel = y_vel.to_f
		@mass = mass.to_f
		@image = image
		@radius = radius.to_f
	end

	def draw
		ratio = @x / @radius
		x = (320 * ratio) + 320
		puts x
		ratio_y = @y / @radius
		y = (320 * ratio_y) + 320
		imagex = Gosu::Image.new("images/#{@image}")
		imagex.draw(x, y, 0)
	end

end