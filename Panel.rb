require 'Constants'
require 'Screen'

module LD16
  module Panel
    include Screen
    attr_reader :panel_parent, :panel_width, :panel_height
    attr_accessor :panel_x, :panel_y
    
    #TODO: work out the best way to z-order panels while still retaining the ability to z-order within panels. 
    #Probable solution: @z - 1/(2+z)
    def init_panel(parent,width,height,x=nil,y=nil)
      @panel_parent, @panel_width, @panel_height = parent, width, height
      @panel_x = x || ((MainWindow.width - width)/2)
      @panel_y = y || ((MainWindow.height - height)/2)
    end
    
    def clip_to(x,y,w,h,&blck)
      @panel_parent.clip_to(x+@panel_x,y+@panel_y,w,h,&blck)
    end
    
    def draw_line(*args)
      MainWindow.draw_line(*args)
    end

    def draw_triangle(*args)
      MainWindow.draw_triangle(*args)
    end
    
    def draw_quad(x1,y1,c1,x2,y2,c2,x3,y3,c3,x4,y4,c4,z)
      @panel_parent.clip_to(@panel_x,@panel_y,@panel_width,@panel_height) do
        @panel_parent.draw_quad(x1+@panel_x,y1+@panel_y,c1,
                             x2+@panel_x,y2+@panel_y,c2,
                             x3+@panel_x,y3+@panel_y,c3,
                             x4+@panel_x,y4+@panel_y,c4,
                             z)
      end
    end
    
    def draw_text(font, text, x, y, z, factor_x=1, factor_y=1, color=0xffffffff, mode=:default)
      @panel_parent.clip_to(@panel_x,@panel_y,@panel_width,@panel_height) do
        @panel_parent.draw_text(text, font, x+@panel_x, y+@panel_y, z, factor_x, factor_y, color, mode)
      end
    end
    
#    def fill(c,z=ZOrder::Splash)
#      draw_quad(0,0,c,Sizes::WindowWidth,0,c,0,Sizes::WindowHeight,c,Sizes::WindowWidth,Sizes::WindowHeight,c,z)
#    end
    
    def mouse_x
      MainWindow.mouse_x - @x
    end
    
    def mouse_y
      MainWindow.mouse_y - @y
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