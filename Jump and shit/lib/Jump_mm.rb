require 'gosu'
require_relative 'collision_detection.rb'
require_relative 'map.rb'
require_relative 'projectile.rb'


#   ***TODO***
#
#   MAKE COLLISION FOR PROJECTILE
#
#   create new floor block that is 24px in height 
#
#   ***TODO***


class Player
    def initialize
        @image = Gosu::Image.new("../img/CharacterSquare.png")
        
        
        @direction = 0
        @speed = 5
        
        @grav = 0.5
        @default_jump_speed = 10
        @jump_speed = @default_jump_speed
        $player_in_air = true
        
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
        if adjacent == "up_adjacent"
            @jump_speed = -0.000001
        end
    end

   
    def move

      $player_x += @direction * @speed
      $player_x %= $width_in_blocks * 32
      
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
        $width_in_blocks = 60
        $height_in_blocks = 34
        width = $width_in_blocks * 32
        height = $height_in_blocks * 32
        # width = 1920
        # height = 1080

        super width, height, fullscreen: true
        self.caption = "Gosu test"

        $player_size = 32
        $player_x = width / 2 - $player_size
        $player_y = 568 
        
        @player = Player.new
        @map = Map.new
        @projectile = Projectile.new
        @collision_detection = Collision_detection.new

    end

    def needs_cursor?
        true
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
        #   Shoot
        #
        if Gosu.button_down? Gosu::MS_LEFT and !$shot_on_cooldown
            @projectile.shoot
        end

        #
        #   get mouse location
        #
        $mouse_x = mouse_x
        $mouse_y = mouse_y
        
        i = 0
        while i < $height_in_blocks
            j = 0
            while j < $width_in_blocks
                if $map_string[j + i*$width_in_blocks] == "#"
                adjacent = @collision_detection.is_adjacent($player_x, $player_y, $player_size, $player_size, j*$block_size, i*$block_size, $block_size, $block_size)
                @player.on_ground?(adjacent)
                on_ground = @player.on_ground?(adjacent)
                if on_ground
                    break
                end
                end
                j += 1
            end

            if on_ground
                break
            end
            i += 1
        end

        #
        #   Jumping
        #
        if (Gosu.button_down? Gosu::KB_W or Gosu::button_down? Gosu::GP_BUTTON_0) and !$player_in_air
            @player.jump
        end


        i = 0
        while i < $height_in_blocks
            j = 0
            while j < $width_in_blocks
                if $map_string[j + i*$width_in_blocks] == "#"
                adjacent = @collision_detection.is_adjacent($player_x, $player_y, $player_size, $player_size, j*$block_size, i*$block_size, $block_size, $block_size)
                @player.restrict_movement(adjacent)
                end
                j += 1
            end
            i += 1
        end

        
        @player.move
        
        
        i = 0
        while i < $height_in_blocks
            j = 0
            while j < $width_in_blocks
                if $map_string[j + i*$width_in_blocks] == "#"
                    collision, axis, projection = @collision_detection.collide?($player_x, $player_y, $player_size, $player_size, j*$block_size, i*$block_size, $block_size, $block_size)
                    @player.project(collision, axis, projection)
                end
                j += 1
            end
            i += 1
        end
        


        @projectile.update_shot
    end

    def draw

        @map.draw
        @projectile.draw
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
