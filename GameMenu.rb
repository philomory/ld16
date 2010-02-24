require 'Menu'
require 'Panel'
require 'Menu/GameSubMenu'
require 'Menu/PlayerSubMenu'
require 'Menu/TerrainSubMenu'
require 'Menu/WorldMapSubMenu'

module LD16
  class GameMenu
    include Panel
    attr_reader :game
    attr_accessor :items_array
    def initialize(game,z=10)
      @game = game
      init_panel(game,MainWindow.width-40,MainWindow.height-100,z)
      
      @selection_index = 0
      @font = Gosu::Font.new(MainWindow.instance,Gosu::default_font_name,20)
      @items_array = [
                      Menu::PlayerSubMenu.new(self),
                      Menu::TerrainSubMenu.new(self),
                      @game.current_terrain.shop.new(self),
                      Menu::WorldMapSubMenu.new(self),
                      Menu::GameSubMenu.new(self,0xEE00FF00),
      ]
    end

    def draw
      @game.draw
      self.fill(0xEE000066,0)
      self.draw_headers
      self.submenu.draw
    end

    def draw_headers
      self.draw_square(10+60*@selection_index,10,40,0xFFFFFFFF,0)
      @items_array.each_with_index do |submenu,index|
        submenu.draw_header(15+60*index,15,30,2)
      end
    end

    def submenu
      @items_array[@selection_index]
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

    def back
      MainWindow.current_screen = @game
    end

  end
end