module LD16
  class Grid
    def self.from_array(array)
      width = array.length
      height = array[0].length
      grid = self.new(width,height)
      grid.instance_variable_set(:@spaces,array)
      return grid
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
    
  end
end