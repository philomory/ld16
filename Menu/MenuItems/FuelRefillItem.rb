require 'Menu/MenuItems/PurchaseItem'

module LD16
  module Menu
    module MenuItems
      class FuelRefillItem < PurchaseItem
        def initialize(menu)
          @menu = menu
          @title = lambda {"Refill all fuel"}
          @cost  = 100
          @can_purchase = lambda {@menu.player.fuel < @menu.player.max_fuel}
        end

        def purchase
          @menu.player.fuel = @menu.player.max_fuel
        end

      end
    end
  end
end