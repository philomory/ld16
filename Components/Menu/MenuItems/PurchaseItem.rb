require 'Menu/MenuItems/BaseMenuItem'

module LD16
  module Menu
    module MenuItems
      class PurchaseItem < BaseMenuItem
        def initialize(menu,title,cost,can_purchase = true,&on_purchase)
          @menu, @title, @cost, @can_purchase = menu,title, cost,can_purchase
          @on_purchase = on_purchase
        end

        def cost
          if @cost.is_a? Proc
            @cost.call
          else
            @cost
          end
        end
        
        def description
          if @description.is_a? Proc
            @description.call
          else
            @description
          end
        end
        
        def can_purchase?
          if @can_purchase.is_a? Proc
            @can_purchase.call
          elsif !defined?(@can_purchase)
            true
          else
            @can_purchase
          end
        end

        def purchase
          @on_purchase.call
        end

        def selected
          if self.can_purchase? && @menu.player.funds >= self.cost
            @menu.player.funds -= self.cost
            self.purchase
          end
        end

      end
    end
  end
end