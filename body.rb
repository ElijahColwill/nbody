require "gosu"
require 'mathn'
require './z_order'
require_relative "z_order"

class Body

	attr_accessor :x, :y, :vel_x, :vel_y, :mass, :image, :force, :g, :ax, :ay, :t

	def initialize(x, y, z, vel_x, vel_y, vel_z, r, mass, image)
        @x = x.to_f
        @y = y.to_f
        #@z = z.to_f
        @x_coordinate = 0
        @y_coordinate = 0
        #@z_coordinate = 0
        @vel_x = vel_x.to_f
        @vel_y = vel_y.to_f
        #@vel_z = vel_z.to_f
        #@r = r
        @mass = mass.to_f
        @image = image
        @force = [0.0, 0.0]
	end

    def set_force(f)
        self.force[0] = f[0]
        self.force[1] = f[1]
        #self.force[2] = f[2]
    end

    def how_far(body1, body2)
    	dx = (body2.x - body1.x)
    	dy = (body2.y - body1.y)
        #dz = (body2.z - body1.z)
        #return [dx, dy, dz]
    end

    def length(body1, body2)
    	distance = how_far(body1, body2)
#       return Math.sqrt((distance[0] * distance[0]) + (distance[1] * distance[1]) * (distance[2] * distance[2]))
    end

    def forcex(mass1, mass2, r)
    	g = 6.67408e-11
    	return (g * mass1 * mass2) / (r ** 2)
    end

    def force_directional(f, distance, radius)
    	return (distance / radius) * f
    end

    def acceleration(f, mass)
    	return (f / mass)
    end

    def distance(v, d0)
    	return d0 + (v * 25000)
    end

    def velocity(a, v0)
    	return v0 + (a * 25000)
    end

    def calculate_force(bodies)
        fx, fy, dx, dy, r = 0.0, 0.0, 0.0, 0.0, 0.0
        
        bodies.each do |body|
            if body == self
            	next
            end
            radius = length(self, body)
            dx = how_far(self, body)[0]
            dy = how_far(self, body)[1]
            #dz = how_far(self, body)[2]

            f = forcex(mass, body.mass, radius)

            fx += force_directional(f, dx, radius)
            fy -= force_directional(f, dy, radius)
            #fz += force_directional(f, dz, radius) 
        end

        #return [fx, fy, fz]
    end

    def set_coordinates(bodies)
        set_force(calculate_force(bodies))

        v0x = vel_x
        v0y = vel_y
        #v0z = vel_z

        ax = acceleration(force[0], mass)
        ay = acceleration(force[1], mass)
        #az = acceleration(force[2], mass)

        self.vel_x = velocity(ax, v0x)
        self.vel_y = velocity(ay, v0y)
        #self.vel_z = velocity(az)

        self.x += distance(vel_x, @x_coordinate)
        self.y -= distance(vel_y, @y_coordinate)
        #self.z += distance(vel_z, @z_coordinate)
    end

#    def z(z_coordinate, radius)
#       sizex, sizey = 0.0       
#       if z_coordinate > radius || z_coordinate < radius
#          #change image size to zero
#       else
#          #scale image size proportionally to how far it is in front or in back. but multiple in variables sizex and sizey
#       end
#       return sizex, sizey
#    end


#   def collide(bodies)
#     didCollide = false
#     second_body = nil
#     bodies.each do |body|
#       if body == self
#           next
#        end
#       if ((self.x - body.x) < (self.r + body.r)) || ((self.y - body.y) < (self.r + body.r))
#            didCollide = true 
#            second_body = body
#            return didCollide, second_body
#       end
#     end
#     return didCollide
#   end

    def convert(radius, image)
        x_coordinate = ((320 * @x) / radius) + 320 - (image.width / 2)
        y_coordinate = ((320 * @y) / radius) + 320 - (image.height / 2)
        #z_coordinate = ((320 * @y) / radius) + 320 - (@r / 2)
        #return x_coordinate, y_coordinate, z_coordinate
    end

    def draw(radius)
        image = Gosu::Image.new("images/#{@image}")
        #@x_coordinate, @y_coordinate, @z_coordinate = convert(radius, image)
        #sizex, sizey = z(@z_coordinate, radius)
        #image.draw(@x_coordinate, @y_coordinate, @z_coordinate) #tell the image to draw at a smaller or larger size in x/y axis based off of sizex and sizey
    end

end