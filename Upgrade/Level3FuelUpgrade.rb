module LD16
  module Upgrade
    module Level3FuelUpgrade
      extend Upgrade
      register(:fuel_tanks,3)
    
      def fuel_tanks
        [super,3].max
      end
      
      def self.title
        "Triple Fuel Tank"
      end
      
      def self.price
        6000
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