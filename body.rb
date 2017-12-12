require "gosu"
require 'mathn'
require_relative "z_order"

class Body

	attr_accessor :x, :y, :vel_x, :vel_y, :mass, :image, :force, :g, :ax, :ay, :t

	def initialize(x, y, vel_x, vel_y, mass, image)
        @x = x.to_f
        @y = y.to_f
        @vel_x = vel_x.to_f
        @vel_y = vel_y.to_f
        @mass = mass.to_f
        @image = image
        @force = [0.0, 0.0]
	end

    def set_force(f)
        self.force[0] = f[0]
        self.force[1] = f[1]
    end

    def how_far(body1, body2)
    	dx = (body2.x - body1.x)
    	dy = (body2.y - body1.y)
    end

    def length(body1, body2)
    	distance = how_far(body1, body2)
        return Math.sqrt((distance[0] * distance[0]) + (distance[1] * distance[1])
    end

    def force(mass1, mass2, r)
    	g = 6.67408e-11
    	return (g * mass1 * mass2) / (r ** 2)
    end

    def force_directional(force, distance, radius)
    	return (distance / radius) * force
    end

    def acceleration(force, mass)
    	return (force / mass)
    end

    def distance(v, v0)
    	return v0 + (v * 25000)
    end

    def velocity(a, v0)
    	return v0 + (a * 25000)
    end

    def calculate_force(bodies)
        f, fx, fy, dx, dy, r = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        
        bodies.each do |body|
            if body == self
            	next
            end
            radius = length(self, body)
            dx = how_far(self, body)[0]
            dy = how_far(self, body)[1]

            f = force(mass, body.mass, radius)

            fx += force_directional(f, dx, radius)
            fy += force_directional(f, dy, radius)

            f = 0.0
        end

        return [fx, fy]
    end

    def set_coordinates(bodies)
        set_force(calculate_force(bodies))

        v0x = vel_x
        v0y = vel_y

        ax = acceleration(force[0], mass)
        ay = acceleration(force[1], mass)

        self.vx = velocity(ax, v0x)
        self.vy = velocity(ay, v0y)

        self.x += distance(v0x, vx)
        self.y += distance(v0y, vy)
    end

end