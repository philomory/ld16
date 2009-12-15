module LD16
  module Sizes
    SquareSize   = 20
    RegionWidth  = 20
    RegionHeight = 20
    WindowWidth  = RegionWidth  * SquareSize
    WindowHeight = RegionHeight * SquareSize
  end

  module ZOrder
    Terrain =  0
    Player  =  1
    HUD     =  3
    Menu    = 10
  end
end