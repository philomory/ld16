module LD16
  module Menu
    class BasicMenu < Screen
      
      def initialize(parent)
        @parent = parent
        @selection_index = 0
        @items_array = []
      end
    
      def back
        MainWindow.current_screen = @parent
      end

    
      def button_down(id)
        case id
        when *[Gosu::KbSpace,Gosu::KbEnter,Gosu::KbReturn]
          @items_array[@selection_index].selected
        when Gosu::KbDown
          @selection_index = (@selection_index + 1) % @items_array.length
        when Gosu::KbUp
          @selection_index = (@selection_index - 1) % @items_array.length
        when Gosu::KbRight
          @items_array[@selection_index].incr
        when Gosu::KbLeft
          @items_array[@selection_index].decr
        when Gosu::KbTab # for use in text fields, mostly. They eat the up and down keys.
          if button_down?(Gosu::KbLeftShift) or button_down?(Gosu::KbRightShift)
            @selection_index = (@selection_index - 1) % @items_array.length
          else
            @selection_index = (@selection_index + 1) % @items_array.length
          end
        when Gosu::KbEscape
          self.back
        end
      end #def button_down
    
    end
    class GameMenu < BasicMenu
      attr_accessor :width, :height, :items_array
      def initialize(parent,z=10)
        super(parent)
        @z = z
        @width  = Sizes::WindowWidth  - 40
        @height = Sizes::WindowHeight - 40
      end
      
      def draw
        @parent.draw
        self.draw_rect(
      end
            
    end
  end
end