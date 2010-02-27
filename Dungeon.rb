require 'Grid'
require 'PRNG'
require 'helper'

module LD16
  # Dungeon generation following algorithm here:
  # http://roguebasin.roguelikedevelopment.org/index.php?title=Grid_Based_Dungeon_Generator
  class Dungeon
    NUMBER_OF_ROOMS = 4
    def initialize(seed,cell_width,cell_height,cells_wide,cells_high)
      @seed = seed
      @width, @height = cell_width * cells_wide, cell_height * cells_high
      
      @prng = PRNG.new(seed)
      @map = Grid.fill(@width,@height) {0}
      cells_for_rooms = []
      supergrid = Grid.new(cells_wide,cells_high)
      cells = supergrid.grid_squares
      NUMBER_OF_ROOMS.times do
        cell = cells[@prng.next(cells.size)]
        cells.delete(cell)
        cells_for_rooms << cell
      end
      cells_for_rooms.each do |cell|
        cell_x = cell.x * cell_width + 1
        cell_y = cell.y * cell_height + 1
        w = cell_width - 2
        h = cell_height - 2
        @map.map_with_coords! do |val,x,y|
          if x.between?(cell_x,cell_x+w) && y.between?(cell_y,cell_y+h)
            1
          else
            val  
          end
        end
      end
      
      p @map
      
    end
    
    
  end
  
end