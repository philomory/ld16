require 'Menu/GameSubMenu'
require 'WorldMapDisplay'

module LD16
  module Menu
    class WorldMapSubMenu < GameSubMenu
      def initialize(game_menu)
        super(game_menu,0xEE0000FF)
        world = game.world
        @world_map_display = WorldMapDisplay.new(world,self,panel_width,panel_height)
      end
      
      def draw
        super
        @world_map_display.draw
        area = game.area
        case area
        when Region
          x,y = area.x, area.y
        when Dungeon
          x,y = area.location.x, area.location.y
        end
        @world_map_display.draw_grid_square(x,y,0xFFFF00FF,1,3)
      end
      
    end
  end
end