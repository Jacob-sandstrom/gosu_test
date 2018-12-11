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

#         @image.draw($player_x - 16, $player_y - 32, 5)
#         @image.draw($player_x, $player_y - 16, 5)
#         @image.draw($player_x - 16, $player_y, 5)
#         @image.draw($player_x - 32, $player_y - 16, 5)
#     end
# end

class Game < Gosu::Window
    def initialize 
        $width_in_blocks = 180
        $height_in_blocks = 102
        width = 1920
        height = 1080
        super width, height, fullscreen:true
        self.caption = "Game"



        $spawnpoint = [$width_in_blocks * 32 /2, $height_in_blocks * 32 /2]
        $enemy_spawn = [width/1.5, height/2]

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
            collision, projection_distance, angle = @collision_detection.circle_with_box_collison($player_x - 16, $player_y - 32, 32, enemy_x, enemy_y, 64, 64)
            angle = 0
        when 90
            collision, projection_distance, angle = @collision_detection.circle_with_box_collison($player_x, $player_y - 16, 32, enemy_x, enemy_y, 64, 64)
            angle = 90
        when 180
            collision, projection_distance, angle = @collision_detection.circle_with_box_collison($player_x - 16, $player_y, 32, enemy_x, enemy_y, 64, 64)
            angle = 180
        when 270
            collision, projection_distance, angle = @collision_detection.circle_with_box_collison($player_x - 32, $player_y - 16, 32, enemy_x, enemy_y, 64, 64)
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
        
        
        
        @player.move
        @enemy.update
        has_player_been_hit
        
        @map_editor.update

        @camera.update
    end


    def draw
        # draw_rect(0, 0, 5760, 3264, Gosu::Color.argb(0xf5_000000), 100)
        # draw_rect($player_x-64 - $cam_x, $player_y-64 - $cam_y, 170, 170, Gosu::Color.argb(0x2f_ffffff), 100)


        @player.draw
        @enemy.draw

        @map_editor.draw

        @camera.draw



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