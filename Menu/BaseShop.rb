require 'Menu/ShopSubMenu'
require 'Menu/MenuItems/FuelRefillItem'
require 'Menu/MenuItems/UpgradeItem'
require 'Upgrade'
LD16::Upgrade.require_all_upgrades

module LD16
  module Menu
    class BaseShop < ShopSubMenu
      
      #TODO: Make upgrades purchased remove themselves from the list
      
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