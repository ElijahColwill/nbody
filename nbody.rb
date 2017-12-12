require "gosu"
require_relative "z_order"

class NbodySimulation < Gosu::Window

  def initialize(file)
    super(640, 640, false)
    self.caption = "NBody simulation"
    @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
    @bodies = readfile(file)
  end

  def readfile(filename)
    number_of_bodies = 0
    radius = 0
    bodies = []
    File.open("./simulations/#{filename}") do |file|
      file.each_line.with_index do |line, i|
        line = 0
        if line == "\n"
          next
        end
        if line == 0 
          number_of_bodies = line
          line += 1
        elsif line == 1
          radius = line
          line += 1
        else
          body = line.split(" ")
          if body[0] == nil
            next 
          end
          if body[0] == "Creator"
            break
          end
          bodies.push(Body.new(body[0], body[1], body[2], body[3], body[4], body[5]))
        end
      end
      return bodies
    end
  end

  def convert(x, y, image)
    x_coordinate = ((320 * x) / radius) + 320 - (image.width / 2)
    y_coordinate = ((320 * y) / radius) + 320 - (img.height / 2)
    return x_coordinate, y_coordinate
  end

  def update
    @bodies.each do |body|
      body.set_coordinates(bodies)
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @bodies.each do |body|
      image = Gosu::Image.new("images/#{body.image}")
      x_coordinate, y_coordinate = convert(body.x, body.y, image)
      image.draw(x_coordinate, y_coordinate, ZOrder::Body)
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