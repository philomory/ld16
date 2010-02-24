require 'Constants'

module LD16
  module Panel
    attr_reader :panel_parent, :panel_width, :panel_height
    attr_accessor :panel_x, :panel_y
    
    def update; end
    def draw; end
    def button_down(id); end
    def button_up(id); end
    
    #TODO: work out the best way to z-order panels while still retaining the ability to z-order within panels. 
    #Probable solution: @z - 1/(1+z) + 1
    def init_panel(parent,width,height,z=0,x=nil,y=nil)
      @panel_parent, @panel_width, @panel_height, @panel_z = parent, width, height, z
      @panel_x = x || ((@panel_parent.panel_width - width)/2)
      @panel_y = y || ((@panel_parent.panel_height - height)/2)
      # p "self: #{self}"
      # p "panel_parent: #{@panel_parent}"
      # p "panel_width: #{@panel_width}"
      # p "panel_height: #{@panel_height}"
      # p "panel_x: #{@panel_x}"
      # p "panel_y: #{@panel_y}"
      # puts
    end
    
    def clip_to(x,y,w,h,&blck)
      @panel_parent.clip_to(px(x),py(y),w,h,&blck)
    end
    
    def inspect
      "<#{self.class}:#{self.object_id}>"
    end
    
    def draw_line(*args)
      MainWindow.draw_line(*args)
    end

    def draw_triangle(*args)
      MainWindow.draw_triangle(*args)
    end
    
    def draw_quad(x1,y1,c1,x2,y2,c2,x3,y3,c3,x4,y4,c4,z)
      self.clip_to(0,0,@panel_width,@panel_height) do
        @panel_parent.draw_quad(px(x1),py(y1),c1,px(x2),py(y2),c2,
                                px(x3),py(y3),c3,px(x4),py(y4),c4,pz(z))
      end
    end
    
    def draw_rect(x,y,w,h,c,z)
      draw_quad(x,y,c,x+w,y,c,x,y+h,c,x+w,y+h,c,z)
    end
    
    def draw_square(x,y,s,c,z)
      draw_rect(x,y,s,s,c,z)
    end
    
    def draw_grid_square(x,y,color,z,padding=0,xmargin=0,ymargin=0,scale = (@scale || Sizes::SquareSize) )
      self.draw_square(x*@scale+padding+xmargin,y*@scale+padding+ymargin,@scale-(padding*2),color,z)
    end
    
    
    def draw_text(font, text, x, y, z, factor_x=1, factor_y=1, color=0xffffffff, mode=:default)
      @panel_parent.clip_to(@panel_x,@panel_y,@panel_width,@panel_height) do
        @panel_parent.draw_text(text, font, px(x), py(y), pz(z), factor_x, factor_y, color, mode)
      end
    end
    
    def draw_text_rel(font, text, x, y, z, rel_x, rel_y, factor_x=1, factor_y=1, color=0xffffffff, mode=:default)
      @panel_parent.clip_to(@panel_x,@panel_y,@panel_width,@panel_height) do
        @panel_parent.draw_text_rel(text, font, px(x), py(y), pz(z), rel_x, rel_y, factor_x, factor_y, color, mode)
      end
    end
    
    def draw_image(image, x, y, z, *args)
      @panel_parent.clip_to(@panel_x,@panel_y,@panel_width,@panel_height) do
        @panel_parent.draw_image(image, px(x), py(y), pz(z), *args)
      end
    end
    
    def fill(c,z=ZOrder::Splash)
      draw_rect(0,0,@panel_width,@panel_height,c,z)
    end
    
    def mouse_x
      @panel_parent.mouse_x - @panel_x
    end
    
    def mouse_y
      @panel_parent.mouse_y - @panel_y
    end
    
    def text_layout(message,font,width=@panel_width)
      message.split("\n").map {|line| self.wordwrap(line,width,font)}.flatten
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
    
    protected
    def px(x)
      return @panel_x + x
    end
    
    def py(y)
      return @panel_y + y
    end
    
    def pz(z)
      return @panel_z + 1 - (1/(1+z)) 
    end  
  end
end