module LD16
  module Upgrade
    module WaterWingsUpgrade
      extend Upgrade
      register(:traversal)
      
      def can_traverse(terrain)
        terrain.is_a?(Terrain::Water) ? true : super
      end
      
      def self.title
        "Water Wings"
      end
      
      def self.description
        "A floatation device. It allows you to travel across water."
      end
      
      def self.price
        5000
      end
    end
  end
end