require 'Menu/MenuItems/BaseMenuItem'

module LD16
  module Menu
    module MenuItems
      class PurchaseItem < BaseMenuItem
        def initialize(menu,title,cost,can_purchase = true,&on_purchase)
          @menu, @title, @cost, @can_purchase = menu,title, cost,can_purchase
        end

        def cost
          if @cost.is_a? Proc
            @cost.call
          else
            @cost
          end
        end

        def can_purchase?
          if @cost.is_a? Proc
            @cost.call
          else
            @cost
          end
        end

        def purchase
          @on_purchase.call
        end

        def selected
          if self.can_purchase? && @menu.player.score >= self.cost
            @menu.player.score -= self.cost
            self.purchase
          end
        end

      end
    end
  end
end