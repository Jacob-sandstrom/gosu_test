require 'gosu'


class Player
    def initialize
        @image = Gosu::Image.new("../img/shipTransparent.png")
        @x = @y = @vel_x = @vel_y = @angle = 0.0
        @score = 0

    end
  
    def warp(x, y)
      @x, @y = x, y
    end
    
    def turn_left
      @angle -= 4.5
    end
    
    def turn_right
      @angle += 4.5
    end
    
    def accelerate
      @vel_x += Gosu.offset_x(@angle, 0.5)
      @vel_y += Gosu.offset_y(@angle, 0.5)
    end
    
    def move
      @x += @vel_x
      @y += @vel_y
      @x %= 800
      @y %= 600
      
      @vel_x *= 0.95
      @vel_y *= 0.95
    end
  
    def draw
      @image.draw_rot(@x, @y, 1, @angle)
    end
  end



class Gosu_test < Gosu::Window
    def initialize
        width = 800
        height = 600
        super width, height
        self.caption = "Gosu test"

        @player = Player.new

    end

    def update
        if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
            @player.turn_left
          end
          if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
            @player.turn_right
          end
          if Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0
            @player.accelerate
          end
          @player.move
    end

    def draw

        @player.draw

    end

    
end

Gosu_test.new.show
