require 'gosu'
require_relative 'collision_detection.rb'
require_relative 'player.rb'
require_relative 'enemy.rb'
require_relative 'map_editor.rb'
require_relative 'camera.rb'




# class Test_box
#     def initialize
#         @image = Gosu::Image.new("../img/testbox.png")

#     end

#     def draw

#         @image.draw($player_x - $cam_x, $player_y - 16 - $cam_y, 5)
#         @image.draw($player_x + 16 - $cam_x, $player_y - $cam_y, 5)
#         @image.draw($player_x - $cam_x, $player_y + 16 - $cam_y, 5)
#         @image.draw($player_x - 16 - $cam_x, $player_y - $cam_y, 5)
#     end
# end

class Game < Gosu::Window
    def initialize 
        $width_in_blocks = 90
        $height_in_blocks = 51
        # $width_in_blocks = 180
        # $height_in_blocks = 102
        width = 1920
        height = 1080
        super width, height, fullscreen:true
        self.caption = "Game"



        $spawnpoint = [$width_in_blocks * 32 /2, $height_in_blocks * 32 /2]
        $enemy_spawn = [1950, 3070]

        @camera = Camera.new

        @collision_detection = Collision_detection.new 
        @player = Player.new
        @enemy = Enemy.new
        @enemies =[]

        @map_editor = Map_editor.new

        # @testbox = Test_box.new

        $font = Gosu::Font.new(self, "Futura", 20)

    end

    def needs_cursor?
        true
    end

    def attack
        display_attack, attack_dir = @player.attack_collision
        enemy_x, enemy_y = @enemy.get_xy
        case attack_dir
        when 0
            collision, projection_distance, angle = @collision_detection.circle_with_box_collison($player_x, $player_y - 16, 32, enemy_x, enemy_y, 64, 64)
            angle = 0
        when 90
            collision, projection_distance, angle = @collision_detection.circle_with_box_collison($player_x + 16, $player_y, 32, enemy_x, enemy_y, 64, 64)
            angle = 90
        when 180
            collision, projection_distance, angle = @collision_detection.circle_with_box_collison($player_x, $player_y + 16, 32, enemy_x, enemy_y, 64, 64)
            angle = 180
        when 270
            collision, projection_distance, angle = @collision_detection.circle_with_box_collison($player_x - 16, $player_y, 32, enemy_x, enemy_y, 64, 64)
            angle = 270
        end
        if collision
            @enemy.hit(angle)
        end

    end

    def has_player_been_hit
        if $player_hit
            absolute_angle = @enemy.absolute_angle
            @player.hit(absolute_angle)
            $player_hit = false
            should_stun = @player.stun_if_blocked
        end
    end

    def check_adjacence

        i = 0
        while i < $height_in_blocks
            if i*$block_size >= $cam_y - 64 && i*$block_size <= $cam_y + 1080 + 64
                j = 0
                while j < $width_in_blocks
                    if j*$block_size >= $cam_x - 64 && j*$block_size <= $cam_x + 1920 + 64
                        if $object_map[j + i*$width_in_blocks] == "#" || $floortiles[j + i*$width_in_blocks] == "1" 
                            adjacent = @collision_detection.is_adjacent($player_x, $player_y, 32, 32, j*$block_size, i*$block_size, $block_size, $block_size)
                        
                            @player.stop_if_adjacent(adjacent)
                            
                        end
                    end
                    j += 1
                end
            end
            i += 1
        end


    end

    def check_collison

        i = 0
        while i < $height_in_blocks
            if i*$block_size >= $cam_y - 64 && i*$block_size <= $cam_y + 1080 + 64
                j = 0
                while j < $width_in_blocks
                    if j*$block_size >= $cam_x - 64 && j*$block_size <= $cam_x + 1920 + 64
                        if $object_map[j + i*$width_in_blocks] == "#" || $floortiles[j + i*$width_in_blocks] == "1" 
                            collision, projection, angle = @collision_detection.aabb_collision($player_x, $player_y, 32, 32, j*$block_size, i*$block_size, $block_size, $block_size)
                            @player.project(collision, projection, angle)

                        elsif $floortiles[j + i*$width_in_blocks] == "4" 
                            collision, projection, angle = @collision_detection.aabb_triangle_collision($player_x, $player_y, 32, 32, j*$block_size, i*$block_size, $block_size, $block_size, "up_left")
                            @player.project(collision, projection, angle)
                        elsif $floortiles[j + i*$width_in_blocks] == "5" 
                            collision, projection, angle = @collision_detection.aabb_triangle_collision($player_x, $player_y, 32, 32, j*$block_size, i*$block_size, $block_size, $block_size, "up_right")
                            @player.project(collision, projection, angle)
                        elsif $floortiles[j + i*$width_in_blocks] == "6" 
                            collision, projection, angle = @collision_detection.aabb_triangle_collision($player_x, $player_y, 32, 32, j*$block_size, i*$block_size, $block_size, $block_size, "down_left")
                            @player.project(collision, projection, angle)
                        elsif $floortiles[j + i*$width_in_blocks] == "7" 
                            collision, projection, angle = @collision_detection.aabb_triangle_collision($player_x, $player_y, 32, 32, j*$block_size, i*$block_size, $block_size, $block_size, "down_right")
                            @player.project(collision, projection, angle)
                            
                        end
                    end
                    j += 1
                end
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

        
        #
        #   Movement    X
        #
        if (Gosu.button_down? Gosu::KB_A or Gosu::button_down? Gosu::GP_LEFT) and (Gosu.button_down? Gosu::KB_D or Gosu::button_down? Gosu::GP_RIGHT)
            @player.dont_move_x
        elsif Gosu.button_down? Gosu::KB_A or Gosu::button_down? Gosu::GP_LEFT
            @player.go_left
        elsif Gosu.button_down? Gosu::KB_D or Gosu::button_down? Gosu::GP_RIGHT
            @player.go_right
        else
            @player.dont_move_x
        end 
        
        #
        #               Y
        #
        if (Gosu.button_down? Gosu::KB_W or Gosu::button_down? Gosu::GP_UP) and (Gosu.button_down? Gosu::KB_S or Gosu::button_down? Gosu::GP_DOWN)
            @player.dont_move_y
        elsif Gosu.button_down? Gosu::KB_W or Gosu::button_down? Gosu::GP_UP
            @player.go_up
        elsif Gosu.button_down? Gosu::KB_S or Gosu::button_down? Gosu::GP_DOWN
            @player.go_down
        else 
            @player.dont_move_y
        end
        
        #   attack
        if (Gosu.button_down? Gosu::KB_K or Gosu::button_down? Gosu::GP_BUTTON_1)
            @player.shield
        else
            @player.dont_shield
        end
        if (Gosu.button_down? Gosu::KB_J or Gosu::button_down? Gosu::GP_BUTTON_0) && !$attack_on_cooldown
            @player.attack
            attack
        end

        @player.facing_direction
        
        check_adjacence
        
        @player.move
        @enemy.update
        has_player_been_hit
        
        @map_editor.update

        
        check_collison
        @camera.update
    end


    def draw
        # draw_rect(0, 0, 5760, 3264, Gosu::Color.argb(0xf5_000000), 100)
        # draw_rect($player_x-64 - $cam_x, $player_y-64 - $cam_y, 170, 170, Gosu::Color.argb(0x2f_ffffff), 100)


        @player.draw
        @enemy.draw

        @map_editor.draw

        @camera.draw

        $font.draw(@draw_collision, 20, 100, 10, scale_x = 2, scale_y = 2, color = 0xff_ffffff)

        $font.draw($player_x, 20, 200, 10, scale_x = 2, scale_y = 2, color = 0xff_ffffff)
        $font.draw($player_y + 16, 20, 230, 10, scale_x = 2, scale_y = 2, color = 0xff_ffffff)

        @collision_detection.draw

        # @testbox.draw
    end


    def button_down(id)
        if id == Gosu::KB_ESCAPE
          close
        else
          super
        end
    end

end


Game.new.show