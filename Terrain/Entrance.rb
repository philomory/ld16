require 'Terrain'

module LD16
  class Terrain
    class Entrance < Terrain 
      attr_reader :seed
      def initialize(seed,*args)
        @seed = seed
        super(*args)
      end
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
        game.enter_dungeon(self)
        MainWindow.current_screen = game
      end
      def special_desc
        "Enter the caverns."
      end
      def name
        "Entrance"
      end
    end
  end
end