require 'Menu/RemoteShop'

module LD16
  Terrain = Struct.new(:x,:y,:z) do
    def value; 2; end
    def cost; 0; end
    def special; end
    def special_desc; "None" end
    def shop; Menu::RemoteShop; end
  end
end

%w{Water Beach Grassland Hill Mountain Base}.each do |type|
  require File.join('Terrain',type)
end

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