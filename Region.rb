require 'Grid'
require 'GridSquare'

module LD16
  class Region
    def initialize(width,height)
      @width, @height = @width, @height
      @terrain = Grid.new(@width,@height)
      #@points_of_interest = Grid.new(@width,@height)
    end
  end
end