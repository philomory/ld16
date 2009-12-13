require 'Grid'
require 'GridSquare'
require 'Perlin'
require 'Terrain'

module LD16
  class Region
    attr_accessor :terrain, :png
    def initialize(width,height)
      @width, @height = width, height
      @terrain = Grid.fill(@width,@height) {|x,y| Terrain.new(x,y,0)}
      @png = Perlin.new(rand(65335),3,0.5)
      self.setup_heightmap(0.15)
      self.setup_terrains
      #@points_of_interest = Grid.new(@width,@height)
    end
    
    
    def setup_heightmap(scale)
      @terrain.each_with_coords do |sq,x,y|
        tmp_z = (@png.perlin_noise(x*scale,y*scale) * 255).to_i
        sq.z = ((tmp_z+255)/2).to_i
        warn sq.z unless (0..255).include?(sq.z)
      end
    end
    
    def setup_terrains
      @terrain.each do |sq|
        sq.type = case sq.z
        when (0...100) then :water
        when (100...110) then :beach
        when (110...150) then :grassland
        when (150...170) then :hill
        else :mountain
        end
      end
    end
    
    
    
  end
end