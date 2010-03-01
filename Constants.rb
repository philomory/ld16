module LD16
  module Sizes
    SquareSize    = 20
    RegionWidth   = 21
    RegionHeight  = 21
    WorldWidth    = 11
    WorldHeight   = 11
    WindowWidth   = RegionWidth  * SquareSize
    WindowHeight  = RegionHeight * SquareSize
    DungeonWidth  = RegionWidth
    DungeonHeight = RegionHeight
    DungeonCellsWide    = 3
    DungeonCellsHigh    = 3
    DungeonCellWidth    = DungeonWidth / DungeonCellsWide
    DungeonCellHeight    = DungeonHeight / DungeonCellsHigh   
  end

  module ZOrder
    Terrain =  0
    Player  =  1
    HUD     =  3
    Menu    = 10
    Splash  = 100
  end
end