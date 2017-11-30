require "gosu"
require "./body"
require "./planet"
require_relative "z_order"

class NbodySimulation < Gosu::Window

  def initialize
    super(640, 640, false)
    self.caption = "NBody simulation"
    @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
    simulation = Body.new("simulations/planets.txt")
    @x, @y, @x_vel, @y_vel, @mass, @image, @planets, @radius = simulation.return
    @items = []
    @earth = Planet.new(@x[0], @y[0], @x_vel[0], @y_vel[0], @mass[0], @image[0], @radius)
    @mars = Planet.new(@x[1], @y[1], @x_vel[1], @y_vel[1], @mass[1], @image[1], @radius)
    @mercury = Planet.new(@x[2], @y[2], @x_vel[2], @y_vel[2], @mass[2], @image[2], @radius)
    @sun = Planet.new(@x[3], @y[3], @x_vel[3], @y_vel[3], @mass[3], @image[3], @radius)
    @mars = Planet.new(@x[4], @y[4], @x_vel[4], @y_vel[4], @mass[4], @image[4], @radius)
  end

  def update
    @earth
    @mars
    @mercury
    @sun
    @mars
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @earth.draw
    @mars.draw
    @mercury.draw
    @sun.draw
    @mars.draw
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
  
end

window = NbodySimulation.new
window.show