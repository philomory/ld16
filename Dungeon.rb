require 'Grid'
require 'PRNG'

module LD16
  class Dungeon
    NUMBER_OF_ROOMS = 4
    def initialize(seed)
      @seed = seed
      @prng = PRNG.new(seed)
      @map = Grid.new(Sizes::RegionWidth,Sizes::RegionHeight) {0}
      cells_for_rooms = []
      supergrid = Grid.new(3,3) {false}
      cells = supergrid.grid_squares
      NUMBER_OF_ROOMS.times do
        cell = cells[@prng.next(cells.size)]
        cells.delete(cell)
        cells_for_rooms << cell
      end
      
      p cells_for_rooms
      
    end
    
    
  end
  
end