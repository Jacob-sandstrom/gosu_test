require 'gosu'




class Player
    def initialize
        @image = Gosu::Image.new("../img/CharacterSquare.png")
        
        @x_direction = 0
        @y_direction = 0
        @speed = 4
        
        @grav = 1.5
        @default_jump_speed = 20
        @jump_speed = @default_jump_speed
        

    end
 
    def go_left
      @x_direction = -1
    end
    
    def go_right
      @x_direction = 1
    end

    def go_down
        @y_direction = 1
    end

    def go_up
        @y_direction = -1
    end


    def dont_move_x
        @x_direction = 0
    end

    def dont_move_y
        @y_direction = 0
    end
    
    def move

        
      $player_x += @x_direction * @speed
      $player_x %= $width

      $player_y += @y_direction * @speed
      $player_y %= $height


    end
  
    def draw
      @image.draw($player_x, $player_y, 1)
    end

  end

class Projectile
    def initialize
        @image = Gosu::Image.new("../img/shipTransparent.png")
        $projectile_x = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        $projectile_y = [-50, -50, -50, -50, -50, -50, -50, -50, -50, -50, -50, -50, -50, -50, -50, -50, -50, -50, -50, -50]
        @max_shots = 20
        @shot_speed = 10
        @shot_iterations = 0
        @cooldown_timer = 0
        @cooldown = 15




        # @draw_iterations = 0
        # @move_iterations = 0

    end


    def shoot
        $projectile_x[@shot_iterations] = $player_x
        $projectile_y[@shot_iterations] = $player_y
        @shot_iterations += 1
        @shot_iterations %=20
        $shot_on_cooldown = true

    end

    def decrease_cooldown
        if $shot_on_cooldown
            if @cooldown_timer >= @cooldown
                $shot_on_cooldown = false
                @cooldown_timer = 0
            else
                @cooldown_timer += 1
            end
        end

    end

    def move
        #
        #   loop instead        Not working
        #
        # @move_iterations = 0
        # while @move_iterations <= @max_shots
        #     $projectile_x[@move_iterations] += @shot_speed
        #     @move_iterations += 1
        # end

        $projectile_x[0] += @shot_speed
        $projectile_x[1] += @shot_speed
        $projectile_x[2] += @shot_speed
        $projectile_x[3] += @shot_speed
        $projectile_x[4] += @shot_speed
        $projectile_x[5] += @shot_speed
        $projectile_x[6] += @shot_speed
        $projectile_x[7] += @shot_speed
        $projectile_x[8] += @shot_speed
        $projectile_x[9] += @shot_speed
        $projectile_x[10] += @shot_speed
        $projectile_x[11] += @shot_speed
        $projectile_x[12] += @shot_speed
        $projectile_x[13] += @shot_speed
        $projectile_x[14] += @shot_speed
        $projectile_x[15] += @shot_speed
        $projectile_x[16] += @shot_speed
        $projectile_x[17] += @shot_speed
        $projectile_x[18] += @shot_speed
        $projectile_x[19] += @shot_speed
    end

    def draw

        #
        #   loop instead        Not working
        #
        # @draw_iterations = 0
        # while @draw_iterations <= @max_shots
        #     @image.draw($projectile_x[@draw_iterations], $projectile_y[@draw_iterations], 0)
        #     @draw_iterations += 1
        # end


        @image.draw_rot($projectile_x[0], $projectile_y[0], 0, 90, center_x = 0, center_y = 1)
        @image.draw_rot($projectile_x[1], $projectile_y[1], 0, 90, center_x = 0, center_y = 1)
        @image.draw_rot($projectile_x[2], $projectile_y[2], 0, 90, center_x = 0, center_y = 1)
        @image.draw_rot($projectile_x[3], $projectile_y[3], 0, 90, center_x = 0, center_y = 1)
        @image.draw_rot($projectile_x[4], $projectile_y[4], 0, 90, center_x = 0, center_y = 1)
        @image.draw_rot($projectile_x[5], $projectile_y[5], 0, 90, center_x = 0, center_y = 1)
        @image.draw_rot($projectile_x[6], $projectile_y[6], 0, 90, center_x = 0, center_y = 1)
        @image.draw_rot($projectile_x[7], $projectile_y[7], 0, 90, center_x = 0, center_y = 1)
        @image.draw_rot($projectile_x[8], $projectile_y[8], 0, 90, center_x = 0, center_y = 1)
        @image.draw_rot($projectile_x[9], $projectile_y[9], 0, 90, center_x = 0, center_y = 1)
        @image.draw_rot($projectile_x[10], $projectile_y[10], 0, 90, center_x = 0, center_y = 1)
        @image.draw_rot($projectile_x[11], $projectile_y[11], 0, 90, center_x = 0, center_y = 1)
        @image.draw_rot($projectile_x[12], $projectile_y[12], 0, 90, center_x = 0, center_y = 1)
        @image.draw_rot($projectile_x[13], $projectile_y[13], 0, 90, center_x = 0, center_y = 1)
        @image.draw_rot($projectile_x[14], $projectile_y[14], 0, 90, center_x = 0, center_y = 1)
        @image.draw_rot($projectile_x[15], $projectile_y[15], 0, 90, center_x = 0, center_y = 1)
        @image.draw_rot($projectile_x[16], $projectile_y[16], 0, 90, center_x = 0, center_y = 1)
        @image.draw_rot($projectile_x[17], $projectile_y[17], 0, 90, center_x = 0, center_y = 1)
        @image.draw_rot($projectile_x[18], $projectile_y[18], 0, 90, center_x = 0, center_y = 1)
        @image.draw_rot($projectile_x[19], $projectile_y[19], 0, 90, center_x = 0, center_y = 1)
        
    end

end

class Gosu_test < Gosu::Window
    def initialize
        $width = 800
        $height = 600
        super $width, $height
        self.caption = "Shoot stuff"

        $player_x = $width / 2
        $player_y = 568
        $shot_on_cooldown = false
        @Projectile = Projectile.new
        @player = Player.new

    end

    def update
        #
        #   Movement    X
        #
        if (Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT) and (Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT)
            @player.dont_move_x
        elsif Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
            @player.go_left
        elsif Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
            @player.go_right
        else
            @player.dont_move_x
        end 
        
        #
        #               Y
        #
        if (Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0) 
            @player.go_up
        end
        if (Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_UP) and (Gosu.button_down? Gosu::KB_DOWN or Gosu::button_down? Gosu::GP_DOWN)
            @player.dont_move_y
        elsif Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_UP
            @player.go_up
        elsif Gosu.button_down? Gosu::KB_DOWN or Gosu::button_down? Gosu::GP_DOWN
            @player.go_down
        else 
            @player.dont_move_y
        end

        
        #
        #   Shoot
        #
        if Gosu.button_down? Gosu::KB_SPACE and !$shot_on_cooldown
            @Projectile.shoot
        end


            @player.move
            @Projectile.decrease_cooldown
            @Projectile.move
    end

    def draw

        @player.draw
        @Projectile.draw

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
