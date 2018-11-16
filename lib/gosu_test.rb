require 'gosu'


class Player
    def initialize
        @image = Gosu::Image.new("../img/CharacterSquare.png")
        
        @direction = 0
        @speed = 3
        
        @grav = 1
        @default_jump_speed = 20
        @jump_speed = @default_jump_speed
        @in_air = false
        @x = @y = 0.0
        

    end
  
    def warp(x, y)
      @x, @y = x, y
    end

    def go_left
      @direction = -1
    end
    
    def go_right
      @direction = 1
    end

    def dont_move
        @direction = 0
    end

    def jump
      @in_air = true
      @jump_speed = @default_jump_speed

    end
    
    def move
      @x += @direction * @speed
      @x %= 800
    #   @y %= 600
      
      if @in_air
        @y -= @jump_speed    
        @jump_speed -= @grav
      end


    end
  
    def draw
      @image.draw(@x, @y, 1)
    end

  end



class Gosu_test < Gosu::Window
    def initialize
        width = 800
        height = 600
        super width, height
        self.caption = "Gosu test"

        
        @height_minus_char_height = 568

        @player = Player.new
        @player.warp(400, 568)

    end

    def update
        #
        #   Movement
        #
        if (Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT) and (Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT)
            @player.dont_move
        elsif Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
            @player.go_left
        
        elsif Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
            @player.go_right
        elsif  !(Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT) and !(Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT)
            @player.dont_move
        end 
        
        #
        #   Jumping
        #
        if (Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0) and !@in_air
            @player.jump
        end

        # if @y >= @height_minus_char_height
        #     @in_air = false
        #     @jump_speed = 0
        #     @y = @height_minus_char_height

        # end
        

            @player.move
    end

    def draw

        @player.draw

    end

    
end

Gosu_test.new.show
