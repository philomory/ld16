require 'Screen'
require 'World'
require 'Player'
require 'GameMenu'
require 'Perlin'
require 'Constants'
require 'EmbarkationScreen'

module LD16
  class Game
    
    include Screen
    
    attr_reader :player, :region, :world
    
    def initialize(tiles_w,tiles_h,scale)
      init_screen
      @width,@height,@scale = tiles_w,tiles_h,scale
      
      #@png = Perlin.new(rand(65335),1,0)
      @png = Perlin.new(rand(65335),4,0.7)
      
      @world = World.new(Sizes::WorldWidth,Sizes::WorldHeight,@width,@height,@png)
      @font = Gosu::Font.new(MainWindow.instance,Gosu::default_font_name,15)
    end
    
    def embarkation_screen
      EmbarkationScreen.new(self,@world)
    end
       
    def embark(x,y)
      @region = @world.load_region(x,y)
      start_point = @region.starting_point
      x,y = *start_point
      @region.create_base(x,y)
      @player = Player.new(x,y,self)
    end
    
    def draw
      @region.terrain.each_with_coords do |sq,x,y| 
        self.draw_grid_square(x,y,sq.color,0) if @region.seen[x,y]
      end
      @player.draw
      @font.draw(" Fuel: #{@player.fuel}", 10,10,5)
      @font.draw("Score: #{@player.score}",10,30,5)
      @font.draw("Funds: #{@player.funds}",10,50,5)
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
      when Gosu::KbEnter  then MainWindow.current_screen = GameMenu.new(self)
      when Gosu::KbReturn then MainWindow.current_screen = GameMenu.new(self)
      when Gosu::KbE      then MainWindow.current_screen = EmbarkationScreen.new(self,@world)
      end
    end
    
    def pass_edge(direction)
      old_x,old_y = @region.x,@region.y
      case direction
      when :north
        new_x,new_y = old_x,old_y-1
        player_x,player_y = @player.x,@height-1
      when :south
        new_x,new_y = old_x,old_y+1
        player_x,player_y = @player.x,0
      when :east
        new_x,new_y = old_x+1,old_y
        player_x,player_y = 0,@player.y
      when :west
        new_x,new_y = old_x-1,old_y
        player_x,player_y = @width-1,@player.y
      end
      @world.save_region(@region,old_x,old_y)
      @region = @world.load_region(new_x,new_y)
      @player.x, @player.y = player_x, player_y
      @player.update_sight
    end
    
    def region_warp(x,y)
      @world.save_region(@region,@region.x,@region.y)
      @region = @world.load_region(x,y)
      @player.update_sight
    end
    
    def local_warp(x,y)
      @player.x, @player.y = x, y
      @player.update_sight
    end
    
    def warp(region_x,region_y,local_x,local_y) 
      @world.save_region(@region,@region.x,@region.y)
      @region = @world.load_region(region_x,region_y)
      @player.x, @player.y = local_x, local_y
      @player.update_sight
    end
    
    def current_terrain
      @region.terrain[@player.x,@player.y]
    end
    
  end
end