require 'Menu/ShopSubMenu'
require 'Menu/MenuItems/FuelPurchaseItem'

module LD16
  module Menu
    class RemoteShop < ShopSubMenu
      def initialize(menu)
        super(menu)
        add(FuelPurchaseItem,0.75)
        add(FuelPurchaseItem,1)
      end
    end
  end
end