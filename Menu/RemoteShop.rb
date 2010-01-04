require 'Menu/ShopSubMenu'
require 'Menu/MenuItems/FuelPurchaseItem'
require 'Menu/MenuItems/FuelRefillItem'
require 'Menu/MenuItems/ReturnToBaseItem'

module LD16
  module Menu
    class RemoteShop < ShopSubMenu
      def initialize(menu)
        super(menu)
        add(FuelRefillItem)
        add(FuelPurchaseItem,0.75)
        add(ReturnToBaseItem)
      end
    end
  end
end