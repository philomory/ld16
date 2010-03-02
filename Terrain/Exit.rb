require 'Terrain'
require 'Menu/DungeonShop'

module LD16
  class Terrain
    class Exit < Terrain 
      def color
        Gosu::Color.new(255,255,0,0)
      end
      def cost
        0
      end
      def value
        0
      end
      def special(game)
        game.exit_dungeon
        MainWindow.current_screen = game
      end
      def special_desc
        "Exit the caverns."
      end
      def name
        "Exit"
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