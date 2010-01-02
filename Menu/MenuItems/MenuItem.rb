require 'Menu/MenuItems/BaseMenuItem'

module LD16
  module Menu
    module MenuItems
      class MenuItem < BaseMenuItem

        def initialize(title,&action)
          @title = title
          @selected_action = action
        end #def initialize

      end
    end
  end
end