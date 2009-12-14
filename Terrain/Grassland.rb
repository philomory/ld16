require 'Terrain'

module LD16
  class Terrain
    class Grassland < Terrain 
      def color
        Gosu::Color.new(z,0,255,0)
      end
      def cost
        10
      end
    end
  end
end