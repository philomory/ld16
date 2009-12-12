require 'enumerator'

module LD16
  class Grid
    include Enumerable
    def self.from_array(array)
      width = array.length
      height = array[0].length
      grid = self.new(width,height)
      grid.instance_variable_set(:@spaces,array)
      return grid
    end
    
    def self.fill(width,height,&fill,with_coordinates = false)
      grid = self.new(width,height)
      if with_coordinates
        grid.enum_with_coords.map
    end
    
    attr_reader :width, :height
    def initialize(width,height)
      @width, @height = width, height
      @spaces = Array.new(@width) {Array.new(@height)}
    end
    def [](x,y)
      return @spaces[x][y]
    end
    
    def []=(x,y,val)
      @spaces[x][y] = val
    end

    def col(x)
      @spaces[x].dup
    end
    
    def row(y)
      @spaces.map {|col| col[y]}
    end
    
    def each
      @spaces.each do |col|
        col.each do |obj|
          yield obj
        end
      end
    end
    
    def each_with_coords
      @spaces.each_with_index do |col,x|
        col.each_with_index do |obj,y|
          yield obj, x, y
        end
      end
    end
    
    def map
      @spaces.map do |col|
        col.map do |obj|
          yield obj
        end
      end
    end
    
    #def map_with_coords
     # @spaces.enum_with_index do
    
  end
end