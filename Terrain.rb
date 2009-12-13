module LD16
  Terrain = Struct.new(:x,:y,:z,:type) do
    def color
      case type
      when :water     then Gosu::Color.new(z,  0,  0,255)
      when :beach     then Gosu::Color.new(z,237,255, 49)
      when :grassland then Gosu::Color.new(z,  0,255,  0)
      when :hill      then Gosu::Color.new(z,100,100,100)
      else                 Gosu::Color.new(z,220,220,220)
      end
    end
    def clamp(num)
      [0,[num,255].min].max
    end
  end
end