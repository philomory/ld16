require 'Menu/GameSubMenu'

module LD16
  module Menu
    class PlayerSubMenu < GameSubMenu
      def initialize(game_menu)
        super(game_menu,0xEEFF00FF)
        text = <<-END_OF_TEXT
        Fuel: #{player.fuel}/#{player.max_fuel}
Funds: #{player.funds}
Score: #{player.score}

Sight: #{player.sight}
Installed Upgrades: 
        #{player.upgrades.map {|u| u.title}.join("\n        ")}
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