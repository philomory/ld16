require 'mixology'

module LD16
  module Upgradable
    def upgrades
      @upgrades ||= []
    end
    
    def install_upgrade(upgrade_module)
      self.upgrades << upgrade_module 
      self.mixin(upgrade_module)
      upgrade_module.install(self) if upgrade_module.respond_to? :install
    end
    
    def uninstall_upgrade(upgrade_module)
      upgrade_module.uninstall(self) if upgrade_module.respond_to? :uninstall
      self.unmix(upgrade_module)
      self.upgrades.delete(upgrade_module)
    end
    
    def upgrade_categories
      self.upgrades.inject({}) do |h,upgrade|
        key,value = upgrade.category, upgrade.level
        unless h[key] && value && h[key] > value
          h[key] = value
        end
        h
      end
    end
    
    def upgrades_in_category(category)
      self.upgrades.select {|u| u.category == category  }
    end
    
    def highest_level_upgrade_in_category(category)
      self.upgrades_in_category(category).max {|a,b| a.level <=> b.level}
    end
  end
end