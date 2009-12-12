module LD16
  Square = Struct.new(:x,:y) do
    def north
      return Square.new(x,y-1)
    end
    def south
      return Square.new(x,y+1)
    end
    def east
      return Square.new(x+1,y)
    end
    def west
      return Square.new(x-1,y)
    end
  end
end