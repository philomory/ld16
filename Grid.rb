require 'enumerator'
require 'GridSquare'

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
    
    def self.fill(width,height,coordinates=false,&fill)
      grid = self.new(width,height)
      if with_coordinates
        grid.map_coords!(&fill)
      else
        grid.map!(&fill)
      end
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
    
    def each_coords
      @spaces.each_with_index do |col,x|
        col.each_index do |y|
          yield x, y
        end
      end
    end
    
    def map
      ary = @spaces.map do |col|
        col.map do |obj|
          yield obj
        end
      end
      return Grid.from_array(ary)
    end
    
    def map!
      @spaces.map! do |col|
        col.map! do |obj|
          yield obj
        end
      end
    end
    
    def map_with_coords
      ary = @spaces.enum_with_index.map do |col,x|
        col.enum_with_index.map do |obj,y|
          yield obj,x,y
        end
      end
      return Grid.from_array(ary)
    end
    
    def map_with_coords!
      @spaces.each_with_index do |col,x|
        @spaces[x].each_with_index do |obj,y|
          @spaces[x][y] = yield obj,x,y
        end
      end
    end
    
    def map_coords
      ary = @spaces.enum_with_index.map do |col,x|
        col.enum_with_index.map do |obj,y|
          yield x, y
        end
      end
    end
    
    def map_coords!
      @spaces.each_with_index do |col,x|
        @spaces[x].each_index do |y|
          @spaces[x][y] = yield x, y
        end
      end
    end
    
    def to_a
      @spaces.map {|col| col.dup}
    end
    
    def flatten
      @spaces.flatten
    end
    
    def grid_squares
      self.map_coords do |x,y|
        GridSquare.new(x,y,self)
      end.flatten
    end
  end
end