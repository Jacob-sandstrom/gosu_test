require 'gosu'
require_relative 'collision_detection.rb'
require_relative 'map.rb'


class Player
    def initialize
        @image = Gosu::Image.new("../img/CharacterSquare.png")
        
        
        @direction = 0
        @speed = 4
        
        @grav = 0.5
        @default_jump_speed = 10
        @jump_speed = @default_jump_speed
        $player_in_air = false
        
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

    def restrict_movement(adjacent)
        if (adjacent == "left_adjacent" && @direction == -1) || (adjacent == "right_adjacent" && @direction == 1) 
            @direction = 0        
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

    def on_ground?(adjacent)      
        if adjacent == "down_adjacent"
            @jump_speed = 0
            $player_in_air = false
            return true
        else
            $player_in_air = true
            return false
        end
    end

    def project(collision, axis, projection)

        if collision
            if axis == "x"
                $player_x -= projection
            else
                $player_y -= projection
            end
        end

    end
  
    def draw
      @image.draw($player_x, $player_y, 1)
    end

end

class Gosu_test < Gosu::Window
    def initialize
        width = 800
        height = 608
        super width, height
        self.caption = "Gosu test"

        $player_size = 32
        $player_x = width / 2 - $player_size
        $player_y = 568
        
        @player = Player.new
        @map = Map.new
        @collision_detection = Collision_detection.new

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


        i = 0
        while i < 19
            j = 0
            while j < 25
                if $map_string[j + i*25] == "#"
                adjacent = @collision_detection.is_adjacent($player_x, $player_y, $player_size, $player_size, j*$block_size, i*$block_size, $block_size, $block_size)
                @player.restrict_movement(adjacent)
                end
                j += 1
            end
            i += 1
        end

        
        @player.move
        
        i = 0
        while i < 19
            j = 0
            while j < 25
                if $map_string[j + i*25] == "#"
                adjacent = @collision_detection.is_adjacent($player_x, $player_y, $player_size, $player_size, j*$block_size, i*$block_size, $block_size, $block_size)
                @player.on_ground?(adjacent)
                if @player.on_ground?(adjacent)
                    break
                end
                end
                j += 1
            end
            i += 1
        end

        i = 0
        while i < 19
            j = 0
            while j < 25
                if $map_string[j + i*25] == "#"
                collision, axis, projection = @collision_detection.collide?($player_x, $player_y, 32, 32, j*32, i*32, $block_size, $block_size)
                @player.project(collision, axis, projection)
                end
                j += 1
            end
            i += 1
        end



    end

    def draw

        @map.draw
        @player.draw


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
