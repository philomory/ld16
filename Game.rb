require 'Screen'
require 'Region'
require 'Player'

module LD16
  class Game < Screen
    attr_accessor :region
    def initialize(tiles_w,tiles_h,scale)
      @width,@height,@scale = tiles_w,tiles_h,scale
      @region = Region.new(@width,@height)
      start_point = @region.terrain.grid_squares.select do |sq| 
        sq.contents.is_a?(Terrain::Grassland)
      end.sort_by {|sq| rand}.first
      @player = Player.new(start_point.x,start_point.y,self)
      @font = Gosu::Font.new(MainWindow.instance,Gosu::default_font_name,15)
    end
    
    def draw
      @region.terrain.each_with_coords do |sq,x,y| 
        self.draw_grid_square(x,y,sq.color,0) if @region.seen[x,y]
      end
      @player.draw
      @font.draw(" Fuel: #{@player.fuel}", 10,10,5)
      @font.draw("Score: #{@player.score}",10,30,5)
    end
    
    def draw_grid_square(x,y,color,z,padding=0)
      self.draw_square(x*@scale+padding,y*@scale+padding,@scale-padding,color,z)
    end
        
    def button_down(id)
      case id
      when Gosu::KbLeft   then @player.move( :west)
      when Gosu::KbRight  then @player.move( :east)
      when Gosu::KbUp     then @player.move(:north)
      when Gosu::KbDown   then @player.move(:south)
      when Gosu::KbSpace  then @player.wait
      when Gosu::KbR      then MainWindow.new_game
      when Gosu::KbEscape then MainWindow.close
      end
    end
    
    
  end
end