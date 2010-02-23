require 'Menu/GameSubMenu'
require 'Menu'

module LD16
  module Menu
    class ShopSubMenu < GameSubMenu
      include Menu
      def initialize(game_menu)
        super(game_menu,0xEE00FFFF)
        self.init_menu
      end
      
      def add(klass,*args)
        super(klass.new(self,*args))
      end
      
      def draw
        super
        @items_array.each_with_index do |item,index|
          selected = (index == @selection_index)
          afford   = (game.player.score >= item.cost)
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