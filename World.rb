require 'Region'

module LD16
  class World
    attr_reader :bases
    def initialize(region_width,region_height,png)
      @region_width, @region_height, @png = region_width, region_height, png
      @regions_mapped_terrain = {}
      @bases = {}
    end
    
    def load_region(x,y)
      region = Region.new(@region_width, @region_height,x,y,@png)
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
    
  end
end