module LD16
  module Menu
    module MenuItems
      class BaseMenuItem

        def title
          if @title.is_a? Proc
            @title.call
          else
            @title
          end
        end

        def selected(menu)
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
    end
  end
end