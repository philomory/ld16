require 'Terrain'

module LD16
  class Terrain
    class Water < Terrain 
      def color
        Gosu::Color.new(z,0,0,255)
      end
      def cost
        100
      end
      def name
        "Water"
      end
    end
  end
end