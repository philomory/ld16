module LD16
  module Upgrade
    module Level6CameraUpgrade
      extend Upgrade
      register(:sight,6)
    
      def sight
        [super,6].max
      end
      
      def self.title
        "Long-range Camera"
      end
      
      def self.description
        "A long-range camera that lets you see 6 tiles away."
      end
      
      def self.price
        3000
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