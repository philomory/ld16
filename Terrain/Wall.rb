require 'Terrain'
require 'Menu/DungeonShop'

module LD16
  class Terrain
    class Wall < Terrain 
      def color
        Gosu::Color.new(255,220,220,200)
      end
      def cost
        100000
      end
      def name
        "Wall"
      end
      def traversable?
        false
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