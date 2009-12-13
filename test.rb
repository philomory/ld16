Dir.chdir(File.dirname(__FILE__))
$:.push(File.join(File.dirname(__FILE__),'ext'))

require 'gosu'
require 'Region'

module LD16
  class TestGame < Gosu::Window
    def initialize(w,h,s)
      @s = s
      super(w*s,h*s,false)
      @r = Region.new(w,h)
    end
    
    def button_down(id)
      if id == Gosu::MsLeft
        seed, scale = rand(65335), rand*1.5
        puts "seed: #{seed}; scale: #{scale}"
        @r.png = Perlin.new(seed,3,0.5)
        @r.setup_heightmap(scale)
      else
        close
      end
    end
    
    def draw_square(x,y,s,c,z)
      draw_quad(x,y,c,x+s,y,c,x,y+s,c,x+s,y+s,c,z)
    end
    
    def draw
      @r.terrain.each_with_coords do |sq,x,y|
        self.draw_square(x*@s,y*@s,@s,sq.color,0)
      end
    end
  end
end

LD16::TestGame.new(20,20,10).show