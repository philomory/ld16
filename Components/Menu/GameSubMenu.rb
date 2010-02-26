require 'Panel'

module LD16
  module Menu
    class GameSubMenu
      include Panel
      Width = 340
      Height = 230
      X_POS = 10
      Y_POS = 60
      Z_POS = 4
      def initialize(game_menu,color)
        @color = color      
        @font = Gosu::Font.new(MainWindow.instance,Gosu::default_font_name,20)
        init_panel(game_menu,Width,Height,Z_POS,X_POS,Y_POS)
      end

      def game
        @panel_parent.game
      end

      def player
        self.game.player
      end

      def region
        self.game.region
      end

      def draw
        self.fill(0xEE000077)
      end

      def draw_header(parent_x,parent_y,s,z)
        @panel_parent.draw_square(parent_x,parent_y,s,@color,z)
      end

    end
  end
end