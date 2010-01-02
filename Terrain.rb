require 'Menu/RemoteShop'

module LD16
  Terrain = Struct.new(:x,:y,:z) do
    def value
      10
    end
    def special; end
    def special_desc; "None"; end
    def shop; Menu::RemoteShop; end
  end
end

%w{Water Beach Grassland Hill Mountain Base}.each do |type|
  require File.join('Terrain',type)
end