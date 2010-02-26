require "Panel"

module LD16
  module Screen
    include Panel
        
    def init_screen
      init_panel(MainWindow.instance,MainWindow.width,MainWindow.height,0,0,0)
    end
    
    def draw_quad(*args)
      MainWindow.draw_quad(*args)
    end

    def draw_text(font,*args)
      font.draw(*args)
    end

    def draw_text_rel(font,*args)
      font.draw_rel(*args)
    end

    def draw_image(image,*args)
      image.draw(*args)
    end
    


    undef panel_x=, panel_y=
 
  end
end