require 'Grid'
require 'GridSquare'
require 'Terrain'

module LD16
  class Region
    def initialize(width,height)
      @width, @height = @width, @height
      @terrain = Grid.fill(@width,@height) {|x,y| Terrain.new(x,y,0)}
      #@points_of_interest = Grid.new(@width,@height)
    end
  end
end