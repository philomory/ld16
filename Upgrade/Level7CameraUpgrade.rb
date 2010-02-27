module LD16
  module Upgrade
    module Level7CameraUpgrade
      extend Upgrade
      register(:sight,7)
    
      def sight
        [super,7].max
      end
      
      def self.title
        "Very-long-range Camera"
      end
      
      def self.price
        7000
      end
      
      def self.install(player)
        player.mixin(self)
        player.update_sight
      end
      
      def self.uninstall(player)
        player.unmix(self)
      end
    end
  end
end