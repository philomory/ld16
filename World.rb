require 'Region'

module LD16
  class World
    attr_reader :bases, :world_map
    def initialize(world_width,world_height,region_width,region_height,png)
      @world_width, @world_height = world_width, world_height
      @region_width, @region_height, @png = region_width, region_height, png
      seed = ((@png.perlin_noise(@png.seed,@png.seed)) * 65535).to_i
      @prng = PRNG.new(seed)
      @regions_mapped_terrain = {}
      @bases = {}
      @dungeon_locations = {}
      allocate_dungeons
      @world_map = self.generate_world_map
    end
    
    def allocate_dungeons
      regions = Grid.new(@world_width,@world_height).grid_squares
      squares = Grid.new(@region_width,@region_height).grid_squares
      num_dungeons.times do
        region = regions[@prng.next(regions.size)]
        regions.delete(region)
        ds = squares[@prng.next(squares.size)]
        @dungeon_locations[[region.x,region.y]] = [ds.x,ds.y,@prng.next(65536)] 
      end
    end
    
    def num_dungeons
      regions = @world_width * @world_height
      min_dungeons = Math.sqrt(regions).to_i
      max_dungeons = [@world_width + @world_height,regions].min
      range = max_dungeons - min_dungeons
      @prng.next(range) + min_dungeons
    end
        
    def load_region(x,y)
      return false unless x.between?(0,@world_width) && y.between?(0,@world_height)
      region = Region.new(@region_width, @region_height,x,y,@png)
      region.generate_terrain
      if (pack_str = @regions_mapped_terrain[[x,y]])
        region.unpack(pack_str)
      end
      if (base_loc = @bases[[x,y]])
        region.create_base(*base_loc)
      end
      if (dungeon_loc = @dungeon_locations[[x,y]])
        region.create_dungeon(*dungeon_loc)
      end
      return region
    end
    
    def save_region(region,x,y)
      @regions_mapped_terrain[[x,y]] = region.pack
      @bases[[x,y]] = region.base if region.base
    end
    
    def generate_world_map
      world_map = Grid.fill(@world_width, @world_height) {0}
      world_map.map_coords! do |x,y|
        r = Region.new(@region_width,@region_height,x,y,@png)
        z = r.approximate_height
        klass = Terrain.of_height(z)
        klass.new(x,y,z)
      end
      world_map
    end
    
  end
end