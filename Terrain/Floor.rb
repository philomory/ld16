require 'Terrain'
require 'Menu/DungeonShop'

module LD16
  class Terrain
    class Floor < Terrain 
      def color
        Gosu::Color.new(90,220,220,200)
      end
      def cost
        5
      end
      def name
        "Floor"
      end
      def traversable?
        true
      end
      def value
        0
      end
      def shop
        Menu::DungeonShop
      end
    end
  end
end