require 'Terrain'

module LD16
  class Terrain
    class Beach < Terrain 
      def color
        Gosu::Color.new(z,237,255,49)
      end
      def cost
        25
      end
    end
  end
end