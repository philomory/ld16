module LD16
  class Dungeon
    include Screen
    def initialize(seed)
      init_screen
      @seed = seed
      @prng = PRNG.new(seed)
    end
    
    
  end
  
end