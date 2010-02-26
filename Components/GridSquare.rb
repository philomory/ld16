module LD16
  class GridSquare
  
    attr_reader :x, :y
    attr_accessor :gird
    def initialize(x,y,grid=nil)
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
    
    def contents
      @grid[@x,@y] if @grid
    end
    
    def inspect
      "GridSquare[#{x},#{y}]: #{self.contents}"
    end
  
  end
end