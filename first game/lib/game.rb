require 'gosu'
require_relative 'collision_detection.rb'
require_relative 'player.rb'
require_relative 'enemy.rb'



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


    end

    def needs_cursor?
        true
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
        if (Gosu.button_down? Gosu::KB_SPACE) && !$attack_on_cooldown
            @player.attack
        end



        @player.move
    end


    def draw
        draw_rect(0, 0, 1000, 700, Gosu::Color.argb(0xff_f0f0f0))
        @player.draw
        @enemy.draw
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