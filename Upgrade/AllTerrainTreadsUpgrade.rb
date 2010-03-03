module LD16
  module Upgrade
    module AllTerrainTreadsUpgrade
      extend Upgrade
      register(:traversal)
      
      def can_traverse(terrain)
        terrain.is_a?(Terrain::Mountain) ? true : super
      end
      
      def self.title
        "All Terrain Treads"
      end
      
      def self.description
        "Advanced treads that allow you to traverse mountainous terrain."
      end
      
      def self.price
        1000
      end
    end
  end
end