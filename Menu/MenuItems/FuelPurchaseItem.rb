require 'Menu/MenuItems/PurchaseItem'

module LD16
  module Menu
    module MenuItems
      class FuelPurchaseItem < PurchaseItem
        def initialize(menu,cost_per)
          @menu = menu
          @amount = 100
          self.validate_amount
          @title = lambda {"Fuel x#{@amount}"}
          @cost  = lambda {(cost_per * @amount).ceil}
          @can_purchase = true
        end

        def validate_amount
          @amount = [[0,@amount].max,@menu.player.max_fuel - @menu.player.fuel].min
        end

        def incr
          @amount += 100
          self.validate_amount
        end

        def decr
          @amount -= 100
          self.validate_amount
        end

        def purchase
          @menu.player.fuel += @amount
          self.validate_amount
        end

      end
    end
  end
end