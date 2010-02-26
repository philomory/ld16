# Allow uniform enumerator syntax across 1.8 and 1.9
require 'enumerator'
module Enumerable
  alias :enum_with_index :each_with_index unless [].respond_to?(:enum_with_index)
  alias :enum_slice :each_slice unless [].respond_to?(:enum_slice)
end

