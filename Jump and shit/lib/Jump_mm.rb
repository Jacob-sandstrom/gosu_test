require 'gosu'
require_relative 'collision_detection.rb'
require_relative 'map.rb'
require_relative 'projectile.rb'


#   ***TODO***
#
#
#   MAKE COLLISION FOR PROJECTILE
#
#
#   ***TODO***


class Player
    def initialize
        @image = Gosu::Image.new("../img/CharacterSquare.png")
        
        
        @direction = 0
        @speed = 5
        
        @grav = 0.5
        $default_jump_speed = 10
        $jump_speed = $default_jump_speed
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
      $jump_speed = $default_jump_speed

    end

    def restrict_movement(adjacent)
        if (adjacent == "left_adjacent" && @direction == -1) || (adjacent == "right_adjacent" && @direction == 1) 
            @direction = 0        
        end
        if adjacent == "up_adjacent"
            $jump_speed = -0.000001
        end
    end

   
    def move
        #   Move in x
        $player_x += @direction * @speed
      
      # Fall if in the air
      if $player_in_air
        $player_y -= $jump_speed    
        $jump_speed -= @grav
      end

    end

    def on_ground?(adjacent)      
        if adjacent == "down_adjacent"
            $jump_speed = 0
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
        $width_in_blocks = 30
        $height_in_blocks = 17
        width = $width_in_blocks * 32
        height = $height_in_blocks * 32
        # width = 1920
        # height = 1080

        super width, height, fullscreen: true
        self.caption = "Gosu test"


        #   Enable to edit map
        @map_editing_enabled = false




        $player_size = 32
        $player_x = width / 2 - $player_size
        $player_y = height / 2
        
        @player = Player.new
        @map = Map.new
        @projectile = Projectile.new
        @collision_detection = Collision_detection.new

    end

    def needs_cursor?
        true
    end

    def update_map
        if $player_x >= $width_in_blocks * $block_size - $player_size / 2
            $player_x = 0
            $map_x += 1
          elsif $player_x <= -$player_size / 2
            $player_x = $width_in_blocks * $block_size - $player_size
            $map_x -= 1
          end
          if $player_y >= $height_in_blocks * $block_size
            $map_y += 1
            $player_y = 0
          elsif $player_y <= -$player_size / 2
            $map_y -= 1
            $player_y = $height_in_blocks * $player_size 
            $jump_speed = $default_jump_speed
          end
    end
    
    def draw_on_map
        if Gosu.button_down? Gosu::MS_LEFT and !$shot_on_cooldown
            i = 0
            while i < $height_in_blocks
                j = 0
                while j < $width_in_blocks
                    collision, axis, projection = @collision_detection.collide?($mouse_x, $mouse_y, 0, 0, j*$block_size, i*$block_size, $block_size, $block_size)
                    if collision
                        if $current_map[j + i*$width_in_blocks] == "#"
                            $current_map[j + i*$width_in_blocks] ="."
                        elsif $current_map[j + i*$width_in_blocks] == "."
                            $current_map[j + i*$width_in_blocks] = "#"
                        end
                        @map.update_existing_map($map_x, $map_y)
                    end
                    j += 1
                end
                i += 1
            end
        end
    end
    
    
    def on_the_ground
        
        i = 0
        while i < $height_in_blocks
            j = 0
            while j < $width_in_blocks
                if $current_map[j + i*$width_in_blocks] == "#"
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
    end

    def stop_x_movement
        i = 0
        while i < $height_in_blocks
            j = 0
            while j < $width_in_blocks
                if $current_map[j + i*$width_in_blocks] == "#"
                adjacent = @collision_detection.is_adjacent($player_x, $player_y, $player_size, $player_size, j*$block_size, i*$block_size, $block_size, $block_size)
                @player.restrict_movement(adjacent)
                end
                j += 1
            end
            i += 1
        end

    end

    def check_collison
        i = 0
        while i < $height_in_blocks
            j = 0
            while j < $width_in_blocks
                if $current_map[j + i*$width_in_blocks] == "#"
                    collision, axis, projection = @collision_detection.collide?($player_x, $player_y, $player_size, $player_size, j*$block_size, i*$block_size, $block_size, $block_size)
                    @player.project(collision, axis, projection)
                end
                j += 1
            end
            i += 1
        end

    end

    def update
        #
        #   get mouse location
        #
        $mouse_x = mouse_x
        $mouse_y = mouse_y

        #   Draw on map with mouse
        if @map_editing_enabled
            draw_on_map
        end
        
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

        


        #   Check if player is on the ground
        on_the_ground

        #
        #   Jumping
        #
        if (Gosu.button_down? Gosu::KB_W or Gosu::button_down? Gosu::GP_BUTTON_0) and !$player_in_air
            @player.jump
        end

        #   stop x movement if adjacent to wall
        stop_x_movement

        #   move
        @player.move

        #   Check collision against all blocks on map
        check_collison

        #   calculate angle, decrease cooldown and move projectile
        @projectile.update_shot

        update_map
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
