require 'Terrain'

module LD16
  class Terrain
    class Water < Terrain 
      def color
        Gosu::Color.new(z,0,0,255)
      end
      def cost
        999999
      end
    end
  end
end