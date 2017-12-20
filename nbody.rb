require "gosu"
require './body'
require_relative "z_order"

class NbodySimulation < Gosu::Window

  def initialize(file)
    super(640, 640, false)
    self.caption = "NBody simulation"
    @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
    @bodies, @radius = readfile(file)
  end


  def readfile(filename)
    number_of_bodies = 0
    radius = 0
    bodies = []
    line_num = 0
    File.open("./simulations/#{filename}").each do |line|
      bodies_counted = 0
      body_property = line.split(" ")
      if body_property[0] == "Creator" || body_property[0] == "//"
        break
      end
      if line_num == 0 
        number_of_bodies = line.to_i
        line_num += 1
      elsif line_num == 1
        radius = line.to_f
        line_num += 1
      else
        if body_property[0] != nil && bodies_counted <= number_of_bodies
          bodies.push(Body.new(body_property[0], body_property[1], body_property[2], body_property[3], body_property[4], body_property[5], #body_property[6], body_property[7], body_property[8])) add three more for radius and z and vel_z 
          bodies_counted += 1
        end
      end
    end
    return bodies, radius
  end

  def update
    @bodies.each do |body|
#     body2, didCollide = body.collide(@bodies) 
#     if didCollide
#        bodies.push(Body.new(body.x, body.y, body.z, body.vel_x, body.vel_y, body.vel_z, (body.r / 2), body.mass, body.image))
#        bodies.push(Body.new(body2.x, body2.y, body2.z, body2.vel_x, body2.vel_y, body2.vel_z, (body2.r / 2), body2.mass, body2.image))
#        # move both bodies in a random direction away from each other (modify vel_x/y/z or x/y/z?? new method in body??)
#     end
      body.set_coordinates(@bodies)
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @bodies.each do |body|
      body.draw(@radius)
    end
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
    
end

if ARGV.length == 0
  file = "planets.txt"
else
  input = ARGV
  file = input[0]
end

window = NbodySimulation.new(file)
window.show