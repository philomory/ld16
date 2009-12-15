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
       
      super(Sizes::WindowWidth,SizesWindowHeight,false)
      self.caption = "LD16 Game"
      self.new_game
      @fps = FPSCounter.new
    end #def initialize
    
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
    end
    
    def button_down(id)
      @current_screen.button_down(id)
    end
    
    def button_up(id)
      @current_screen.button_up(id)
    end
    
    # MainWindow is a singleton. This allows me to call methods on MainWindow
    # that I really want to sent to MainWindow.instance, cutting out a lot of
    # useless verbosity. And it avoids ill-performing method_missing hacks.
    (MainWindow.public_instance_methods - MainWindow.public_methods).each do |meth|
      (class << MainWindow; self; end).class_eval do
        define_method(meth) do |*args|
          MainWindow.instance.send(meth,*args)   
        end
      end   
    end
  end
end