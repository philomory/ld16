require 'Terrain'

module LD16
  class Terrain
    class Hill < Terrain 
      def color
        Gosu::Color.new(z,100,190,100)
      end
      def cost
        50
      end
    end
  end
end