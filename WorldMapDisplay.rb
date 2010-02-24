module LD16
  class WorldMapDisplay
    include Panel
    def initialize(world,*panel_args)
      @world = world
      @map = world.world_map
      init_panel(*panel_args)
      max_square_width = panel_width / @map.width
      max_square_height = panel_height / @map.height
      @scale = [max_square_width,max_square_height].min
      @xmargin = (panel_width  - (@scale * @map.width )) / 2
      @ymargin = (panel_height - (@scale * @map.height)) / 2
    end
    
    def draw
      @map.each_with_coords do |sq,x,y| 
        self.draw_grid_square(x,y,sq.color,0,0,@xmargin,@ymargin)
      end
    end
  end
end