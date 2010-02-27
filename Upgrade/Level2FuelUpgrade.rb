module LD16
  module Upgrade
    module Level2FuelUpgrade
      extend Upgrade
      register(:fuel_tanks,2)
    
      def fuel_tanks
        [super,2].max
      end
      
      def self.title
        "Double Fuel Tank"
      end
      
      def self.price
        3000
      end
      
      def self.install(player)
        player.mixin(self)
      end
      
      def self.uninstall(player)
        player.unmix(self)
      end
    end
  end
end