require 'Menu/ShopSubMenu'
require 'Menu/MenuItems/FuelRefillItem'

module LD16
  module Menu
    class BaseShop < ShopSubMenu
      def initialize(menu)
        super(menu)
        add(FuelRefillItem)
      end
    end
  end
end