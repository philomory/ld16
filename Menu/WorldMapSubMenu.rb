require 'Menu/GameSubMenu'
require 'WorldMapDisplay'

module LD16
  module Menu
    class WorldMapSubMenu < GameSubMenu
      def initialize(game_menu)
        super(game_menu,0xEE0000FF)
        world = game_menu.game.world
        @world_map_display = WorldMapDisplay.new(world,self,panel_width,panel_height)
      end
      
      def draw
        super
        @world_map_display.draw
      end
      
    end
  end
end