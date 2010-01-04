require 'GridSquare'

module LD16
  class Player
    attr_accessor :fuel, :score, :x, :y
    attr_reader :max_fuel, :upgrades, :sight
    def initialize(x,y,game)
      @x,@y,@game = x,y,game
      @max_fuel   =      1000
      @fuel       = @max_fuel
      @score      =         0
      @sight      =         4
      @upgrades   =        []
      self.update_sight
    end
    
    def move(dir)
      destination = GridSquare.new(@x,@y,@game.region.terrain).send(dir)
      if destination.contents == OutOfBounds
        @game.pass_edge(dir)
      else
        cost = destination.contents.cost
        if @fuel >= cost
          @fuel -= cost
          @x,@y = *destination
          self.update_sight
        else
          #flash fuel later
        end
      end
    end
    
    def update_sight
      @game.region.seen.around(@x,@y,@sight).each do |sq|
        unless @game.region.seen[*sq]
          @score += @game.region.terrain[*sq].value
          @game.region.seen[*sq] = true
        end
      end
    end
    
    def wait
      @fuel += 30
      @fuel = 1000 if @fuel > 1000
    end
    
    def draw
      @game.draw_grid_square(@x,@y,0xFFFF00FF,1,1)
    end
  end
end