require 'Menu/RemoteShop'

module LD16
  Terrain = Struct.new(:x,:y,:z) do
    def value; 5; end
    def cost; 0; end
    def special(game); end
    def special_desc; "None" end
    def shop; Menu::RemoteShop; end
    def traversable?; true; end
  end
end

Dir['Terrain/*.rb'].each {|file| require file }

class LD16::Terrain
  def self.of_height(z)
    case z
    when (  0...100) then Water
    when (100...110) then Beach
    when (110...150) then Grassland
    when (150...170) then Hill
    else                  Mountain
    end
  end
end