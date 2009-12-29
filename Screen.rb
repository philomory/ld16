module LD16
  module Screen
    attr_reader :parent
    
    def update; end
    
    def draw; end
    
    def clip_to(*args,&blck)
      MainWindow.clip_to(*args,&blck)
    end
    
    def draw_line(*args)
      MainWindow.draw_line(*args)
    end

    def draw_triangle(*args)
      MainWindow.draw_triangle(*args)
    end
    
    def draw_quad(*args)
      MainWindow.draw_quad(*args)
    end
    
    def draw_rect(x,y,w,h,c,z)
      draw_quad(x,y,c,x+w,y,c,x,y+h,c,x+w,y+h,c,z)
    end
    
    def draw_square(x,y,s,c,z)
      draw_rect(x,y,s,s,c,z)
    end
    
#    def fill(c,z=ZOrder::Splash)
#      draw_quad(0,0,c,Sizes::WindowWidth,0,c,0,Sizes::WindowHeight,c,Sizes::WindowWidth,Sizes::WindowHeight,c,z)
#    end
    
    def button_down(id); end
    
    def button_up(id); end
    
    def button_down?(id)
      MainWindow.button_down?(id)
    end
    
    def char_to_button_id(char)
      MainWindow.char_to_button_id(char)
    end
    
    def button_id_to_char(id)
      MainWindow.button_id_to_char(id)
    end
    
    def mouse_x
      MainWindow.mouse_x
    end
    
    def mouse_y
      MainWindow.mouse_y
    end
    
    def draw_text(font,*args)
      @font.draw_text(*args)
    end
    
    def wordwrap(message,width,font)
      word_array = message.split(' ')
      lines = [word_array.shift]
      word_array.each do |word|
        if font.text_width("#{lines[-1]} #{word}") < width
          lines[-1] << ' ' << word
        else
          lines.push(word)
        end
      end
      return lines
    end
    
  end
end