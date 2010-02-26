require 'Grid'
require 'GridSquare'
require 'Perlin'
require 'Terrain'

module LD16
  class Region
    attr_accessor :terrain, :seen, :png, :base
    attr_reader :x, :y
    
    def initialize(width,height,x,y,png)
      @width, @height, @x, @y, @png = width, height, x, y, png
      @x_off, @y_off = x*width, y*height
      @scale = 0.05
    end
    
    def generate_terrain
      @terrain = Grid.fill(@width,@height) {0}
      @seen = Grid.fill(@width,@height) {false}
      self.setup_heightmap
      self.setup_terrain
    end
    
    def setup_heightmap
      @terrain.map_coords! do |x,y|
        z = height(x,y)
        warn z unless (0..255).include?(z)
        z
      end
    end
    
    def height(x,y)
      tmp_z = (@png.perlin_noise((x+@x_off)*@scale,(y+@y_off)*@scale) * 255).to_i
      ((tmp_z+255)/2).to_i
    end
    
    def setup_terrain
      @terrain.map_with_coords! do |z,x,y|
        klass = Terrain.of_height(z)
        klass.new(x,y,z)
      end
    end
    
    def create_base(x,y)
      @base = [x,y]
      z = @terrain[x,y].z
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
    
    def approximate_height
      center  = height(10,10)
      sides   = height( 0,10) + height(10, 0) + height(21,10) + height(10,21)
      corners = height( 0, 0) + height( 0,21) + height(21, 0) + height(21,21)
      return center/4 + sides/8 + corners/16
    end
    
    def starting_point
      @terrain.grid_squares.select do |sq| 
        sq.contents.traverseable?
      end.sort_by {|sq| rand}.first
    end
  end
end