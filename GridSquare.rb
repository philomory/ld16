module LD16
  class GridSquare
  
    attr_reader :x, :y, :grid
    def initialize(x,y,grid)
      @x, @y, @grid = x, y, grid
    end
    
    def to_a
      [@x,@y]
    end
    
    def north
      return GridSquare.new(@x,@y-1,@grid)
    end
    def south
      return GridSquare.new(@x,@y+1,@grid)
    end
    def east
      return GridSquare.new(@x+1,@y,@grid)
    end
    def west
      return GridSquare.new(@x-1,@y,@grid)
    end
    
    def contains
      @grid[@x,@y]
    end
    
    def to_s
      "GridSquare[#{x},#{y}]: #{self.contains}"
    end
  
  end
end