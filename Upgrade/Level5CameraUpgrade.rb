module LD16
  module Upgrade
    module Level5CameraUpgrade
      extend Upgrade
      register(:sight,5)
    
      def sight
        [super,5].max
      end
      
      def self.title
        "Mid-range Camera"
      end
      
      def self.price
        500
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