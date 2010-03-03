require 'Menu'

module LD16
  module Menu
    class ShopSelectionPanel
      include Panel
      include Menu
      def initialize(shop,font,bottom)
        @shop, @font = shop, font
        self.init_panel(shop,shop.panel_width,shop.panel_height-bottom)
        self.init_menu(false)
        @view_index = 0
      end
      
      def items_shown_at_once
        6
      end
      
      def add(klass,*args)
        super(klass.new(@shop,*args))
      end
      
      def next
        super
        if @selection_index > @view_index + items_shown_at_once - 1
          @view_index += 1
        end
      end
      
      def prev
        super
        if @selection_index < @view_index 
          @view_index -= 1
        end
      end
      
      def draw
        super
        self.draw_text(@font,@view_index,0,0,1)
        self.draw_text(@font,@selection_index,0,20,1)
        @items_array[@view_index,items_shown_at_once].each_with_index do |item,index|
          selected = (index == (@selection_index - @view_index))
          afford   = (@shop.game.player.funds >= item.cost)
          color = case [selected, afford] 
            when [ true, true] then 0xFFFFFFFF 
            when [ true,false] then 0xFFFFAAAA
            when [false, true] then 0xCCFFFFFF
            when [false,false] then 0xCCFFAAAA
          end 
          self.draw_text(@font,item.title,10,5+20*index,5,1,1,color)
          self.draw_text_rel(@font,item.cost,@panel_width-10,5+20*index,5,1,0,1,1,color)
        end
      end
    end
  end
end