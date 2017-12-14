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
    File.open("./simulations/#{filename}").each_with_index do |line, i|
      body_property = line.split(" ")
      if i == 0 
        number_of_bodies = line.to_i
      elsif i == 1
        radius = line.to_f
      else
        bodies.push(Body.new(body_property[0], body_property[1], body_property[2], body_property[3], body_property[4], body_property[5]))
      end
    end
    return bodies, radius
  end

  def update
    @bodies.each do |body|
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