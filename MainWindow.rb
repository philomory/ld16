require 'gosu'
#require 'helper'

require 'Constants'
require 'Screen'
require 'Game'

require 'FPSCounter'
#require 'ImageManager'

module LD16
  class MainWindow < Gosu::Window

    attr_accessor :current_screen
    attr_reader :main_menu


    # I'm implimenting Singleton here myself rather than using the Singleton
    # module in the Ruby Standard Library, because the Ruby Standard Library
    # version doesn't behave quite the way I need it to. For one of the things
    # it does 'wrong', see http://www.ruby-forum.com/topic/179676
    private_class_method :new
    def self.instance
      unless @__instance__
        new
      end
      @__instance__
    end

    def initialize
      # More Singleton stuff.
      self.class.instance_variable_set(:@__instance__,self)
       
      super(Sizes::WindowWidth,Sizes::WindowHeight,false,16.666666666*2)
      self.caption = "LD16 Game"
      self.new_game
      @fps = FPSCounter.new
      @needs_redraw = true
    end #def initialize
    
    def needs_redraw?
      @needs_redraw
    end
    
    def update
      @fps.register_tick
      @current_screen.update
    end
    
    def new_game
      @current_screen = Game.new(20,20,20)
    end
    
    def draw
      # Because draw is utterly without side-effects (in terms of game state;
      # obviously it has the 'side effect' of placing an image on the screen),
      # there should be no risk in silently catching and discarding exceptions
      # during the call to draw. Of course, it's better during development to
      # have them around so that they point out bugs, but for the user it's
      # better to have a single munged frame than to have the whole app crash
      # just because I passed bad arguments to some draw function.
      #
      # In the future, though, I hope to throw some intelligent crash-logging
      # into the picture.
      @current_screen.draw # rescue nil
      #ImageManager.image('pointer').draw(self.mouse_x-6,self.mouse_y,ZOrder::Pointer)
      self.caption = "LD16 Game: #{@fps.fps} frames per second."
      @needs_redraw = false 
    end
    
    def button_down(id)
      @needs_redraw = true
      @current_screen.button_down(id)
    end
    
    def button_up(id)
      @current_screen.button_up(id)
    end
    
    
    # MainWindow is a singleton. This allows me to call methods on MainWindow
    # that I really want to sent to MainWindow.instance, cutting out a lot of
    # useless verbosity. And it avoids ill-performing method_missing hacks.
    #
    # clip_to is handled sepearately because it takes a block and define_method
    # doesn't handle blocks correctly in Ruby 1.8.
    
    def MainWindow.clip_to(*args,&blck)
      MainWindow.instance.clip_to(*args,&blck)
    end
    
    (MainWindow.public_instance_methods - MainWindow.public_methods).each do |meth|
      (class << MainWindow; self; end).class_eval do
        define_method(meth) do |*args|
          MainWindow.instance.send(meth,*args)   
        end
      end   
    end
  end
end