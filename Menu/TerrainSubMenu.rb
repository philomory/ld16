require 'Menu/GameSubMenu'

module LD16
  module Menu
    class TerrainSubMenu < GameSubMenu
      def initialize(game_menu)
        super(game_menu,0xEE00FF00)
        terrain = region.terrain[player.x,player.y]
        text = <<-END_OF_TEXT
        #{terrain.name} (#{terrain.x},#{terrain.y})
Value: #{terrain.value}
Move Cost: #{terrain.cost}
Special: #{terrain.special_desc}
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