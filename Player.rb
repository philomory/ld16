require 'GridSquare'
require 'Upgradable'

module LD16
  class Player
    include Upgradable
    
    attr_accessor :fuel, :funds, :score, :x, :y, :max_fuel, :sight
    def initialize(x,y,game)
      @x,@y,@game = x,y,game
      @max_fuel   =      5000
      @fuel       = @max_fuel
      @score      =         0
      @funds      =         0
      @sight      =         4
      self.update_sight
    end
    
    def move(dir)
      destination = GridSquare.new(@x,@y,@game.region.terrain).send(dir)
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
      @game.region.seen.around(@x,@y,self.sight).each do |sq|
        unless @game.region.seen[*sq]
          self.receive_points @game.region.terrain[*sq].value
          @game.region.seen[*sq] = true
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