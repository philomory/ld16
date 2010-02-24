require 'Region'

module LD16
  class World
    attr_reader :bases, :world_map
    def initialize(world_width,world_height,region_width,region_height,png)
      @world_width, @world_height = world_width, world_height
      @region_width, @region_height, @png = region_width, region_height, png
      @regions_mapped_terrain = {}
      @bases = {}
      @world_map = self.generate_world_map
    end
    
    def load_region(x,y)
      region = Region.new(@region_width, @region_height,x,y,@png)
      region.generate_terrain
      if (pack_str = @regions_mapped_terrain[[x,y]])
        region.unpack(pack_str)
      end
      if (base_loc = @bases[[x,y]])
        region.create_base(*base_loc)
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