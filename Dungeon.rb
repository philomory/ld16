require 'Grid'
require 'PRNG'
require 'helper'
require 'PermissiveFieldOfView'
require 'ShadowcastingFieldOfView'

module LD16
  # Dungeon generation following algorithm here:
  # http://roguebasin.roguelikedevelopment.org/index.php?title=Grid_Based_Dungeon_Generator
  class Dungeon
    #include ShadowcastingFieldOfView
    include PermissiveFieldOfView
    attr_reader :terrain, :location, :region, :exit
    def initialize(location,region)
      seed, @location, @region = location.seed, location, region
      @cell_width, @cell_height = Sizes::DungeonCellWidth, Sizes::DungeonCellHeight
      @width, @height = Sizes::DungeonWidth, Sizes::DungeonHeight
      @prng = PRNG.new(seed)
      @terrain = Grid.fill(@width,@height) {|x,y| Terrain::Wall.new(x,y,255)}
      @seen = Grid.fill(@width,@height) {false}
      @room_centers = {}
      cells_for_rooms = []
      supergrid = Grid.new(Sizes::DungeonCellsWide,Sizes::DungeonCellsHigh)
      cells = supergrid.grid_squares
      num_rooms.times do
        cell = cells[@prng.next(cells.size)]
        cells.delete(cell)
        cells_for_rooms << cell
      end
      cells_for_rooms.each do |cell|
        make_room_in_cell(cell)
      end

      create_exit

      cells_for_rooms.each_cons(2) do |cell1,cell2|
        connect_cells_with_corridor(cell1,cell2)
      end     
    end

    def num_rooms
      high, wide = Sizes::DungeonCellsHigh, Sizes::DungeonCellsWide
      cells = high*wide
      min_rooms = Math.sqrt(cells).to_i
      max_rooms = [high + wide,cells].min
      range = max_rooms - min_rooms
      @prng.next(range) + min_rooms
    end

    def make_room_in_cell(cell)
      cell_x = cell.x * @cell_width + 1
      cell_y = cell.y * @cell_height + 1
      w = @cell_width - 2
      h = @cell_height - 2
      center_x = cell_x + w/2
      center_y = cell_y + h/2
      @room_centers[cell] = GridSquare.new(center_x,center_y,@terrain)
      @terrain.map_with_coords! do |val,x,y|
        if x.between?(cell_x,cell_x+w) && y.between?(cell_y,cell_y+h)
          Terrain::Floor.new(x,y,40)
        else
          val  
        end
      end
    end
    
    def create_exit
      available = @terrain.grid_squares.select {|sq| sq.contents.traversable?}
      pick = @prng.next(available.size)
      exit = available[pick]
      @terrain[*exit] = Terrain::Exit.new(exit.x,exit.y,40)
      @exit = exit
    end
    
    def connect_cells_with_corridor(cell1,cell2)
      ns = cell2.y - cell1.y # positive means head north, negative south
      ew = cell2.x - cell1.x # positive means head east, negative west
      room_center = @room_centers[cell2]
      if ns != 0 and ew == 0 # head north or south *only
        carve_northsouth(room_center,ns)
      elsif ns == 0 and ew != 0 #head east or west only
        carve_eastwest(room_center,ew)
      elsif ns != 0 and ew != 0 # need both north/south and east/west
        corner = carve_northsouth(room_center,ns)
        carve_eastwest(corner,ew)
      end
        
    end

    def carve_northsouth(square,vector)
      direction = vector > 0 ? :north : :south
      steps     = vector.abs * @cell_height
      carve(square,direction,steps)
    end

    def carve_eastwest(square,vector)
      direction = vector > 0 ? :west : :east
      steps     = vector.abs * @cell_width
      carve(square,direction,steps)
    end

    def carve(square,direction, steps)
      steps.times do
        square = square.send(direction)
        @terrain[*square] = Terrain::Floor.new(square.x,square.y,40) unless @terrain[*square].traversable?
      end
      return square
    end
    
    def update_view(player)
      @seen.map! {false}
      do_fov(player.x,player.y,player.sight)
    end
    
    def blocked?(x,y)
      !@terrain[x,y].traversable?
    end
    
    def light(x,y)
      @seen[x,y] = true
    end
    
    def visible?(x,y)
      @seen[x,y]
    end
    
  end

end