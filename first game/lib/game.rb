require 'gosu'
require_relative 'collision_detection.rb'
require_relative 'player.rb'
require_relative 'enemy.rb'



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
        width = 1000
        height = 700
        super width, height
        self.caption = "Game"



        $spawnpoint = [width/4, height/2]
        $enemy_spawn = [width/1.5, height/2]

        @collision_detection = Collision_detection.new 
        @player = Player.new
        @enemy = Enemy.new
        @enemies =[]

        # @testbox = Test_box.new

        $font = Gosu::Font.new(self, "Futura", 20)

    end

    def needs_cursor?
        true
    end

    def attack
        display_attack, attack_dir = @player.attack_collision
        case attack_dir
        when 0
            collision, projection_distance, angle = @collision_detection.circle_with_box_collison($player_x - 16, $player_y - 32, 32, $enemy_x, $enemy_y, 64, 64)
            angle = 0
        when 90
            collision, projection_distance, angle = @collision_detection.circle_with_box_collison($player_x, $player_y - 16, 32, $enemy_x, $enemy_y, 64, 64)
            angle = 90
        when 180
            collision, projection_distance, angle = @collision_detection.circle_with_box_collison($player_x - 16, $player_y, 32, $enemy_x, $enemy_y, 64, 64)
            angle = 180
        when 270
            collision, projection_distance, angle = @collision_detection.circle_with_box_collison($player_x - 32, $player_y - 16, 32, $enemy_x, $enemy_y, 64, 64)
            angle = 270
        end
        if collision
            @enemy.hit(angle)
        end

    end

    def has_player_been_hit
        if $player_hit
            @player.hit($absolute_angle)
            $player_hit = false


        end
    end
    

    def update
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
        if (Gosu.button_down? Gosu::KB_SPACE or Gosu::button_down? Gosu::GP_BUTTON_0) && !$attack_on_cooldown
            @player.attack
            attack
        end



        @player.move
        @enemy.update
        
        has_player_been_hit


    end


    def draw
        draw_rect(0, 0, 1000, 700, Gosu::Color.argb(0xff_f0f0f0))
        @player.draw
        @enemy.draw


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