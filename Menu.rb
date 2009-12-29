module LD16
  module Menu
    class BasicMenu
      include Screen
      def initialize(parent)
        @parent = parent
        @selection_index = 0
        @items_array = []
        @font = Gosu::Font.new(MainWindow.instance,Gosu::default_font_name,20)
      end

      def back
        MainWindow.current_screen = @parent if @parent
      end

      def current
        @items_array[@selection_index]
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

      def add(item)
        @items_array << item
        return self
      end

      def add_back
        self.add(BackItem.new(self))
      end

    end


    class GameSubMenu < BasicMenu
      
    
    end


    class BaseMenuItem

      def title
        if @title.is_a? Proc
          @title.call
        else
          @title
        end
      end

      def selected
        if @selected_action
          @selected_action.call
        end
      end

      def incr
        if @incr_action
          @incr_action.call
        end
      end

      def decr
        if @decr_action
          @decr_action.call
        end
      end

      def draw(font,x,y,color)
        font.draw_rel(self.title,Sizes::WindowWidth/2,y,ZOrder::Splash,0.5,0,1,1,color)
      end #draw
    end

    class MenuItem < BaseMenuItem

      def initialize(title,&action)
        @title = title
        @selected_action = action
      end #def initialize

    end

    class BackItem < BaseMenuItem
      def initialize(menu,title="Back")
        @menu, @title = menu, title
      end

      def selected
        @menu.back
      end
    end

  end
end