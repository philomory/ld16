require 'Screen'
require 'WorldMapDisplay'

module LD16
  class EmbarkationScreen
    include Screen
    def initialize(game,world)
      init_screen
      @game, @world = game, world
      @map_display = WorldMapDisplay.new(@world,self,panel_width,panel_height-40,0,0,40)
      @font = Gosu::Font.new(MainWindow.instance,Gosu::default_font_name,30)
      @cursor_loc = GridSquare.new(0,0,@world.world_map)
    end
    
    def draw
      @font.draw("Select an location to embark:",5,5,5)
      @map_display.draw
      draw_cursor
    end
    
    def draw_cursor
      x,y = *@cursor_loc
      color = @cursor_loc.contents.traverseable? ? 0xFFFF00FF : 0xFFFF0000
      @map_display.draw_grid_square(x,y,color,1,@map_display.scale/4)
    end
    
    def button_down(id)
      case id
      when Gosu::KbLeft   then move_cursor(:west)
      when Gosu::KbRight  then move_cursor(:east)
      when Gosu::KbUp     then move_cursor(:north)
      when Gosu::KbDown   then move_cursor(:south)
      when Gosu::KbEnter  then select_location
      when Gosu::KbReturn then select_location
      end
    end
    
    def move_cursor(dir)
      destination = @cursor_loc.send(dir)
      @cursor_loc = destination unless destination.contents == OutOfBounds 
    end
    
    def select_location
      if @cursor_loc.contents.traverseable?
        @game.embark(*@cursor_loc)
        MainWindow.current_screen = @game
      end
    end
  end
end