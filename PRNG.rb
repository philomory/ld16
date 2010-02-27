require 'Perlin'

module LD16
  class PRNG
    attr_accessor :index
    attr_reader :seed
    def initialize(seed)
      @seed = seed
      @png = Perlin.new(seed,1,0)
      @index = 0
    end
    
    def [](index,scale=0)
      result = @png.noise(index,0).abs
      result = (result * scale).to_i if scale > 0
      return result
    end
    
    def next(scale = 0)
      result = self[@index,scale]
      @index += 1
      return result
    end
    
    def prev(scale = 0)
      @index -= 1
      return self[@index,scale]
    end
    
  end
end