module LD16
  Terrain = Struct.new(:x,:y,:z) do
    def value
      10
    end
    def special; end
  end
end