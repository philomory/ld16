require 'Menu/MenuItems/PurchaseItem'

module LD16
  module Menu
    module MenuItems
      class UpgradeItem < PurchaseItem
        def initialize(menu,upgrade)
          player = menu.game.player
          can_purchase = lambda {!player.upgrades.include?(upgrade)}
          title = "Upgrade: #{upgrade.title}"
          @description = upgrade.description
          super(menu,title,upgrade.price,can_purchase) do
            player.install_upgrade(upgrade)
            @menu.items_array.delete(self)
          end
        end
      end
    end
  end
end