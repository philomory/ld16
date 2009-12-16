require 'Grid'
require 'GridSquare'
require 'Perlin'
require 'Terrain'

module LD16
  class Region
    attr_accessor :terrain, :seen, :png, :base
    def initialize(width,height)
      @width, @height = width, height
      @terrain = Grid.fill(@width,@height) {0}
      @seen = Grid.fill(@width,@height) {false}
      @png = Perlin.new(rand(65335),3,0.5)
      self.setup_heightmap(0.15)
      self.setup_terrains
      #@points_of_interest = Grid.new(@width,@height)
    end
    
    
    def setup_heightmap(scale)
      @terrain.map_coords! do |x,y|
        tmp_z = (@png.perlin_noise(x*scale,y*scale) * 255).to_i
        z = ((tmp_z+255)/2).to_i
        warn z unless (0..255).include?(z)
        z
      end
    end
    
    def setup_terrains
      @terrain.map_with_coords! do |z,x,y|
        klass = case z
        when (  0...100) then Terrain::Water
        when (100...110) then Terrain::Beach
        when (110...150) then Terrain::Grassland
        when (150...170) then Terrain::Hill
        else                  Terrain::Mountain
        end
        klass.new(x,y,z)
      end
    end
    
    def create_base(x,y,z)
      @base = [x,y]
      @terrain[x,y] = Terrain::Base.new(x,y,z)
    end
    
    def pack
      bitstring = @seen.flatten.inject("") do |str,sq|
        str << (sq ? "1" : "0")
      end
      return [bitstring].pack("B*")
    end
    
    def unpack(packed_string)
      bitstring = packed_string.unpack("B*")[0]
      seen_ary = bitstring.split("").map {|x| x == "1"}.enum_slice(@width).to_a
      @seen = Grid.from_array(seen_ary)
    end
    
    
    
  end
end