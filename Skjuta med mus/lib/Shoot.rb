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
        @pew = Gosu::Sample.new("../sound/Pew.wav")


        @max_shots = 20
        $projectile_x = Array.new(@max_shots, 0)
        $projectile_y = Array.new(@max_shots, -50)
        @angle        = Array.new(@max_shots, 0)
        
        @shot_speed = 20
        @shot_iterations = 0
        @cooldown_timer = 0
        @cooldown = 15




        # @draw_iterations = 0
        # @move_iterations = 0

    end

    def angle

        @current_angle = (Math.atan2(($player_y - $mouse_y), ($player_x - $mouse_x)) * 180 / Math::PI - 90)
        # $player_y - @window.mouse_y
        # $player_x - @window.mouse_x


    end


    def shoot
        $projectile_x[@shot_iterations] = $player_x
        $projectile_y[@shot_iterations] = $player_y
        @angle[@shot_iterations] = @current_angle
        @shot_iterations += 1
        @shot_iterations %= @max_shots
        $shot_on_cooldown = true
        @pew.play
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
        #     $projectile_x[@move_iterations] += Gosu.offset_x(@angle[@move_iterations], @shot_speed)
        #     $projectile_x[@move_iterations] += Gosu.offset_x(@angle[@move_iterations], @shot_speed)
        #     @move_iterations += 1
        # end

        $projectile_x[0] += Gosu.offset_x(@angle[0], @shot_speed)
        $projectile_x[1] += Gosu.offset_x(@angle[1], @shot_speed)
        $projectile_x[2] += Gosu.offset_x(@angle[2], @shot_speed)
        $projectile_x[3] += Gosu.offset_x(@angle[3], @shot_speed)
        $projectile_x[4] += Gosu.offset_x(@angle[4], @shot_speed)
        $projectile_x[5] += Gosu.offset_x(@angle[5], @shot_speed)
        $projectile_x[6] += Gosu.offset_x(@angle[6], @shot_speed)
        $projectile_x[7] += Gosu.offset_x(@angle[7], @shot_speed)
        $projectile_x[8] += Gosu.offset_x(@angle[8], @shot_speed)
        $projectile_x[9] += Gosu.offset_x(@angle[9], @shot_speed)
        $projectile_x[10] += Gosu.offset_x(@angle[10], @shot_speed)
        $projectile_x[11] += Gosu.offset_x(@angle[11], @shot_speed)
        $projectile_x[12] += Gosu.offset_x(@angle[12], @shot_speed)
        $projectile_x[13] += Gosu.offset_x(@angle[13], @shot_speed)
        $projectile_x[14] += Gosu.offset_x(@angle[14], @shot_speed)
        $projectile_x[15] += Gosu.offset_x(@angle[15], @shot_speed)
        $projectile_x[16] += Gosu.offset_x(@angle[16], @shot_speed)
        $projectile_x[17] += Gosu.offset_x(@angle[17], @shot_speed)
        $projectile_x[18] += Gosu.offset_x(@angle[18], @shot_speed)
        $projectile_x[19] += Gosu.offset_x(@angle[19], @shot_speed)


        $projectile_y[0] += Gosu.offset_y(@angle[0], @shot_speed)
        $projectile_y[1] += Gosu.offset_y(@angle[1], @shot_speed)
        $projectile_y[2] += Gosu.offset_y(@angle[2], @shot_speed)
        $projectile_y[3] += Gosu.offset_y(@angle[3], @shot_speed)
        $projectile_y[4] += Gosu.offset_y(@angle[4], @shot_speed)
        $projectile_y[5] += Gosu.offset_y(@angle[5], @shot_speed)
        $projectile_y[6] += Gosu.offset_y(@angle[6], @shot_speed)
        $projectile_y[7] += Gosu.offset_y(@angle[7], @shot_speed)
        $projectile_y[8] += Gosu.offset_y(@angle[8], @shot_speed)
        $projectile_y[9] += Gosu.offset_y(@angle[9], @shot_speed)
        $projectile_y[10] += Gosu.offset_y(@angle[10], @shot_speed)
        $projectile_y[11] += Gosu.offset_y(@angle[11], @shot_speed)
        $projectile_y[12] += Gosu.offset_y(@angle[12], @shot_speed)
        $projectile_y[13] += Gosu.offset_y(@angle[13], @shot_speed)
        $projectile_y[14] += Gosu.offset_y(@angle[14], @shot_speed)
        $projectile_y[15] += Gosu.offset_y(@angle[15], @shot_speed)
        $projectile_y[16] += Gosu.offset_y(@angle[16], @shot_speed)
        $projectile_y[17] += Gosu.offset_y(@angle[17], @shot_speed)
        $projectile_y[18] += Gosu.offset_y(@angle[18], @shot_speed)
        $projectile_y[19] += Gosu.offset_y(@angle[19], @shot_speed)

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


        @image.draw_rot($projectile_x[0] + 16, $projectile_y[0] + 16, 0, @angle[0], center_x = 0.5, center_y = 0.5)
        @image.draw_rot($projectile_x[1] + 16, $projectile_y[1] + 16, 0, @angle[1], center_x = 0.5, center_y = 0.5)
        @image.draw_rot($projectile_x[2] + 16, $projectile_y[2] + 16, 0, @angle[2], center_x = 0.5, center_y = 0.5)
        @image.draw_rot($projectile_x[3] + 16, $projectile_y[3] + 16, 0, @angle[3], center_x = 0.5, center_y = 0.5)
        @image.draw_rot($projectile_x[4] + 16, $projectile_y[4] + 16, 0, @angle[4], center_x = 0.5, center_y = 0.5)
        @image.draw_rot($projectile_x[5] + 16, $projectile_y[5] + 16, 0, @angle[5], center_x = 0.5, center_y = 0.5)
        @image.draw_rot($projectile_x[6] + 16, $projectile_y[6] + 16, 0, @angle[6], center_x = 0.5, center_y = 0.5)
        @image.draw_rot($projectile_x[7] + 16, $projectile_y[7] + 16, 0, @angle[7], center_x = 0.5, center_y = 0.5)
        @image.draw_rot($projectile_x[8] + 16, $projectile_y[8] + 16, 0, @angle[8], center_x = 0.5, center_y = 0.5)
        @image.draw_rot($projectile_x[9] + 16, $projectile_y[9] + 16, 0, @angle[9], center_x = 0.5, center_y = 0.5)
        @image.draw_rot($projectile_x[10] + 16, $projectile_y[10] + 16, 0, @angle[10], center_x = 0.5, center_y = 0.5)
        @image.draw_rot($projectile_x[11] + 16, $projectile_y[11] + 16, 0, @angle[11], center_x = 0.5, center_y = 0.5)
        @image.draw_rot($projectile_x[12] + 16, $projectile_y[12] + 16, 0, @angle[12], center_x = 0.5, center_y = 0.5)
        @image.draw_rot($projectile_x[13] + 16, $projectile_y[13] + 16, 0, @angle[13], center_x = 0.5, center_y = 0.5)
        @image.draw_rot($projectile_x[14] + 16, $projectile_y[14] + 16, 0, @angle[14], center_x = 0.5, center_y = 0.5)
        @image.draw_rot($projectile_x[15] + 16, $projectile_y[15] + 16, 0, @angle[15], center_x = 0.5, center_y = 0.5)
        @image.draw_rot($projectile_x[16] + 16, $projectile_y[16] + 16, 0, @angle[16], center_x = 0.5, center_y = 0.5)
        @image.draw_rot($projectile_x[17] + 16, $projectile_y[17] + 16, 0, @angle[17], center_x = 0.5, center_y = 0.5)
        @image.draw_rot($projectile_x[18] + 16, $projectile_y[18] + 16, 0, @angle[18], center_x = 0.5, center_y = 0.5)
        @image.draw_rot($projectile_x[19] + 16, $projectile_y[19] + 16, 0, @angle[19], center_x = 0.5, center_y = 0.5)
        
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

        
        #
        #   Shoot
        #
        if Gosu.button_down? Gosu::MS_LEFT and !$shot_on_cooldown
            @Projectile.shoot
        end

        #
        #   get mouse location
        #
        $mouse_x = mouse_x
        $mouse_y = mouse_y


        #
        #   call functions
        #
        @player.move
        @Projectile.angle
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
