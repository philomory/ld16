require 'Terrain'

module LD16
  class Terrain
    class Base < Terrain 
      def color
        Gosu::Color.new(255,0,255,255)
      end
      def cost
        0
      end
      def value
        0
      end
      def special
        puts "Player activated Base special"
      end
    end
  end
end