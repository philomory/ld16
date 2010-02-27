module LD16
  module Upgrade
    attr_reader :category, :level
    def register(category,level=nil)
      Upgrade.register_upgrade(self)
      @category, @level = category, level
    end
    
    def kv
      {self.category => self.level}
    end
    
    def self.register_upgrade(upgrade)
      @registered_upgrades ||= []
      @registered_upgrades << upgrade
    end
    
    def self.registered_upgrades
      @registered_upgrades || []
    end
    
    def self.improvements_for_player(player)
      Upgrade.registered_upgrades.reject do |upgrade|
        hi_level = player.highest_level_upgrade_in_category(upgrade.category)
        (upgrade.level && hi_level && hi_level.level >= upgrade.level) || (player.upgrades.include? upgrade)
      end
    end
    
    def self.require_all_upgrades
      Dir['Upgrade/*.rb'].each {|file| require file }
    end
    
  end
end