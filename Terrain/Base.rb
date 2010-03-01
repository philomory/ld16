require 'Terrain'
require 'Menu/BaseShop'

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
      def special(game)
        puts "Player activated Base special"
      end
      def special_desc
        "It does a thing!"
      end
      def name
        "Base Station"
      end
      def shop
        Menu::BaseShop
      end
    end
  end
end