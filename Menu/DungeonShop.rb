require 'Menu/GameSubMenu'

module LD16
  module Menu
    class DungeonShop < GameSubMenu
      def initialize(game_menu)
        super(game_menu,0xEE00FFFF)
        text = <<-END_OF_TEXT
        You cannot buy here.
END_OF_TEXT
        @lines = self.text_layout(text,@font,@panel_width-20)
      end
      
      def draw
        super
        @lines.each_with_index do |line,index|
          self.draw_text(@font,line,10,5+20*index,5)
        end
      end      
    end
  end
end