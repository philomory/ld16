module LD16
  module Upgrade
    module Level4FuelUpgrade
      extend Upgrade
      register(:fuel_tanks,4)
    
      def fuel_tanks
        [super,4].max
      end
      
      def self.title
        "Quad Fuel Tank"
      end
      
      def self.description
        "A huge tank that holds four times as much fuel."
      end
      
      def self.price
        10000
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