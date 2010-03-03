require 'Menu/ShopSubMenu'
require 'Menu/MenuItems/FuelRefillItem'
require 'Menu/MenuItems/UpgradeItem'
require 'Upgrade'
LD16::Upgrade.require_all_upgrades

module LD16
  module Menu
    class BaseShop < ShopSubMenu
      
      #TODO: Consumable items, such as the Projectile Short Range Camera (reveals a square)
      #TODO: Add dropshipping to transport from base to any region, for a moderate fee
      #TODO: Add dropshipping w/ new base to essentially re-embark somwhere else.
      
      def initialize(menu)
        super(menu)
        add(FuelRefillItem)
        Upgrade.improvements_for_player(menu.game.player).each do |upgrade|
          add(UpgradeItem,upgrade)
        end
        self.items_array.sort! {|a,b| a.cost <=> b.cost }
      end
    end
  end
end