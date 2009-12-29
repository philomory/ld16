require 'Menu'
require 'Panel'

module LD16
  class GameMenu < Menu::BasicMenu
    include Panel
    attr_accessor :items_array
    def initialize(game,z=10)
      super(game)
      @z = z
      init_panel(game,Sizes::WindowWidth-40,Sizes::WindowHeight-40)
      @items_array = [Menu::GameSubMenu.new(parent)]
    end

    def draw
      @parent.draw
      self.draw_rect(0,0,@panel_width,@panel_height,0xEE000033,@z)
    end

    def submenu
      self.current
    end

    def button_down(id)
      case id
      when Gosu::KbRight
        @selection_index = (@selection_index + 1) % @items_array.length
      when Gosu::KbLeft
        @selection_index = (@selection_index - 1) % @items_array.length
      when Gosu::KbEscape
        self.back
      else
        self.submenu.button_down(id) 
      end
    end #def button_down

  end
end