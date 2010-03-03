require 'Panel'

module LD16
  module Menu
    class ShopDescriptionPanel
      include Panel
      def initialize(shop,font,height)
        @shop, @font = shop, font
        init_panel(shop,shop.panel_width,40,0,0,shop.panel_height-40)
      end
      
      def draw
        text = @shop.current.description.to_s
        lines = text_layout(text,@font,panel_width-20)
        lines.each_with_index do |line,index|
          self.draw_text(@font,line,10,5+20*index,5)
        end
      end
      
    end
  end
end