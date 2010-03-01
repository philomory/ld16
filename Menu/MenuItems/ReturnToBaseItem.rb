require 'Menu/MenuItems/PurchaseItem'

module LD16
  module Menu
    module MenuItems
      class ReturnToBaseItem < PurchaseItem
        def initialize(menu)
          @menu = menu
          @title = lambda {menu.area.base ? "Tow back to Base" : "Airlift back to Base"}
          @cost  = lambda {menu.area.base ? 250 : 1000}
        end

        def purchase
          game = @menu.game
          if (base = game.area.base)
            game.local_warp(*base)
          else
            r_x, r_y = game.area.x, game.area.y
            nearest = game.world.bases.sort_by {|region,sq| (r_x - sq[0]).abs + (r_y - sq[1]).abs}.first
            game.warp(*(nearest.flatten))
          end
          @menu.panel_parent.back
        end

      end
    end
  end
end