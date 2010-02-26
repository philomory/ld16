module LD16
  module Menu
    module MenuItems; end
    include MenuItems
    attr_accessor :selection_index, :items_array, :actions
    def init_menu
      @selection_index = 0
      @items_array = []
      @actions = {
        Gosu::KbUp     => :prev,
        Gosu::KbDown   => :next,
        Gosu::KbEnter  => :select_current,
        Gosu::KbReturn => :select_current,
        Gosu::KbNumpadAdd => :incr_current,
        Gosu::KbNumpadSubtract => :decr_current,
        MainWindow.char_to_button_id(']') => :decr_current,
        MainWindow.char_to_button_id('[') => :incr_current
      }
    end
    
    def button_down(id)
      if (action = @actions[id]) && self.respond_to?(action)
        self.send(action)
      end
    end
    
    def current
      @items_array[@selection_index]
    end
    
    def select_current
      self.current.selected if self.current.respond_to?(:selected)
    end
    
    def incr_current
      self.current.incr if self.current.respond_to?(:incr)
    end
    
    def decr_current
      self.current.decr if self.current.respond_to?(:decr)
    end
    
    def next
      @selection_index = (@selection_index + 1) % @items_array.length
    end
    
    def prev
      @selection_index = (@selection_index - 1) % @items_array.length
    end
    
    def add(item)
      @items_array << item
      return self
    end
    
  end
end