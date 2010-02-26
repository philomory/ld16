require 'Terrain'

module LD16
  class Terrain
    class Mountain < Terrain 
      def color
        Gosu::Color.new(z,220,220,200)
      end
      def cost
        75
      end
      def name
        "Mountain"
      end
      def traverseable?
        false
      end
    end
  end
end