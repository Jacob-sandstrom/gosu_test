require 'gosu'


class Object
    def initialize
        @image = Gosu::Image.new("../img/platform.png")

        $platform_x = 100
        $platform_y = 500

    end



    def draw
        @image.draw($platform_x, $platform_y, 0)

    end

end

class Player
    def initialize
        @image = Gosu::Image.new("../img/CharacterSquare.png")
        
        @direction = 0
        @speed = 4
        
        @grav = 0.15
        @default_jump_speed = 5
        @jump_speed = @default_jump_speed
        
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
      $player_in_air = true
      @jump_speed = @default_jump_speed

    end

    def going_to_collide

        if $player_y >= 568 and $player_y != 568
            $player_in_air = false
            @jump_speed = 0
            $player_y = 568

        elsif $player_x + 32 >= $platform_x && $player_x <= $platform_x + 96 && $player_y <= $platform_y && $player_y + 32 >= $platform_y

            if (@jump_speed.abs) == @jump_speed && @jump_speed != 0
                $player_y = $platform_y + 32
            else     
                $player_in_air = false
                $player_y = $platform_y - 32
            end

            @jump_speed = 0
        else
            $player_in_air = true
        end

    end

    def move

      $player_x += @direction * @speed
      $player_x %= 800
      
      if $player_in_air
        $player_y -= @jump_speed    
        @jump_speed -= @grav
      end

    end
  
    def draw
      @image.draw($player_x, $player_y, 1)
    end

  end

class Gosu_test < Gosu::Window
    def initialize
        width = 800
        height = 600
        super width, height
        self.caption = "Gosu test"


        $player_x = width / 2
        $player_y = 568
        $player_in_air = false
        @player = Player.new
        @object = Object.new

    end

    def update
        #
        #   Movement
        #
        if (Gosu.button_down? Gosu::KB_A or Gosu::button_down? Gosu::GP_LEFT) and (Gosu.button_down? Gosu::KB_D or Gosu::button_down? Gosu::GP_RIGHT)
            @player.dont_move
        elsif Gosu.button_down? Gosu::KB_A or Gosu::button_down? Gosu::GP_LEFT
            @player.go_left
        
        elsif Gosu.button_down? Gosu::KB_D or Gosu::button_down? Gosu::GP_RIGHT
            @player.go_right
        elsif  !(Gosu.button_down? Gosu::KB_A or Gosu::button_down? Gosu::GP_LEFT) and !(Gosu.button_down? Gosu::KB_D or Gosu::button_down? Gosu::GP_RIGHT)
            @player.dont_move
        end 
        
        #
        #   Jumping
        #
        if (Gosu.button_down? Gosu::KB_W or Gosu::button_down? Gosu::GP_BUTTON_0) and !$player_in_air
            @player.jump
        end


        
        @player.move
        @player.going_to_collide
    end

    def draw

        @player.draw
        @object.draw

    end


    def button_down(id)
        if id == Gosu::KB_ESCAPE
          close
        else
          super
        end
      end

    
end

Gosu_test.new.show
