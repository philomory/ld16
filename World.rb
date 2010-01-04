module LD16
  class World
    def initialize(region_width,region_height,png)
      @region_width, @region_height, @png = region_width, region_height, png
      @regions_mapped_terrain = {}
      @bases = []
      @current_offsets = [0,0]
    end
    
    def save_region
      
    end
    
  end
end