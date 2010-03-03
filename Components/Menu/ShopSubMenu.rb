require 'Menu/GameSubMenu'
require 'Menu/ShopSelectionPanel'
require 'Menu/ShopDescriptionPanel'
require 'forwardable'
require 'Menu'

module LD16
  module Menu
    class ShopSubMenu < GameSubMenu
      include MenuItems
      extend Forwardable
      def_delegators :@selection_panel, :add, :button_down, :selection_index, :items_array, :actions, :current
      
      def initialize(game_menu)
        super(game_menu,0xEE00FFFF)
        @selection_panel = ShopSelectionPanel.new(self,@font,60)
        @description_panel = ShopDescriptionPanel.new(self,@font,60)
      end
      
      def draw
        @selection_panel.draw
        @description_panel.draw
      end
      
    end
  end
end