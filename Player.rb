require 'GridSquare'
require 'Upgradable'

module LD16
  class Player
    include Upgradable
    
    attr_accessor :fuel, :funds, :score, :x, :y, :sight
    def initialize(x,y,game)
      @x,@y,@game = x,y,game
      @fuel  = max_fuel
      @score =       0
      @funds =       0
      @sight =       4
      self.update_sight
    end
    
    def fuel_tanks
      1
    end
    
    def fuel_per_tank
      5000
    end
    
    def max_fuel
      fuel_tanks * fuel_per_tank
    end
    
    def move(dir)
      destination = GridSquare.new(@x,@y,@game.area.terrain).send(dir)
      if destination.contents == OutOfBounds
        @game.pass_edge(dir)
      else
        cost = destination.contents.cost
        if self.can_traverse(destination.contents)
          if @fuel >= cost
            @fuel -= cost
            @x,@y = *destination
            self.update_sight
          else
            #flash fuel later
          end
        end
      end
    end
    
    def update_sight
      @game.area.player_moved 
      @game.area.terrain.around(@x,@y,self.sight).each do |sq|
        unless @game.area.visible?(*sq)
          self.receive_points @game.area.terrain[*sq].value
          @game.area.player_sees(*sq)
        end
      end
    end
    
    def wait
      @fuel += 30
      @fuel = [@fuel, self.max_fuel].min
    end
    
    def draw
      @game.draw_grid_square(@x,@y,0xFFFF00FF,1,1)
    end
    
    def can_traverse(terrain)
      case terrain
      when Terrain::Water then false
      when Terrain::Mountain then false
      else true
      end
    end
    
    def receive_points(points)
      @score += points
      @funds += points
    end
    
  end
end