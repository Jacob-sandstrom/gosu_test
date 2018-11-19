require 'gosu'




class Player
    def initialize
        @image = Gosu::Image.new("../img/CharacterSquare.png")
        
        @direction = 0
        @speed = 4
        
        @grav = 1.5
        @default_jump_speed = 20
        @jump_speed = @default_jump_speed
        # @x = @y = 0.0
        

    end
  
    def warp(x, y)
      @x, @y = x, y
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

    def x_location
        return @x
    end

    def y_location
        return @y
    end

    def going_to_collide

        if $player_y >= 568 and $player_y != 568
            $player_in_air = false
            @jump_speed = 0
            $player_y = 568

        end
        

    end

    def update

        

        
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

class Projectile
    def initialize
        @image = Gosu::Image.new("../img/shipTransparent.png")
        $projectile_x = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        $projectile_y = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        @shot_speed = 20
        @i = 0


    end


    def shoot
        $projectile_x[@i] = $player_x
        $projectile_y[@i] = $player_y
        @i += 1
        @i %=20
        $shot_on_cooldown = true

    end

    def move
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

        @image.draw($projectile_x[0], $projectile_y[0], 0)
        @image.draw($projectile_x[1], $projectile_y[1], 0)
        @image.draw($projectile_x[2], $projectile_y[2], 0)
        @image.draw($projectile_x[3], $projectile_y[3], 0)
        @image.draw($projectile_x[4], $projectile_y[4], 0)
        @image.draw($projectile_x[5], $projectile_y[5], 0)
        @image.draw($projectile_x[6], $projectile_y[6], 0)
        @image.draw($projectile_x[7], $projectile_y[7], 0)
        @image.draw($projectile_x[8], $projectile_y[8], 0)
        @image.draw($projectile_x[9], $projectile_y[9], 0)
        @image.draw($projectile_x[10], $projectile_y[10], 0)
        @image.draw($projectile_x[11], $projectile_y[11], 0)
        @image.draw($projectile_x[12], $projectile_y[12], 0)
        @image.draw($projectile_x[13], $projectile_y[13], 0)
        @image.draw($projectile_x[14], $projectile_y[14], 0)
        @image.draw($projectile_x[15], $projectile_y[15], 0)
        @image.draw($projectile_x[16], $projectile_y[16], 0)
        @image.draw($projectile_x[17], $projectile_y[17], 0)
        @image.draw($projectile_x[18], $projectile_y[18], 0)
        @image.draw($projectile_x[19], $projectile_y[19], 0)
        
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
        $shot_on_cooldown = false
        @Projectile = Projectile.new
        @player = Player.new

    end

    def update
        #
        #   Movement
        #
        if (Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT) and (Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT)
            @player.dont_move
        elsif Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
            @player.go_left
        
        elsif Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
            @player.go_right
        elsif  !(Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT) and !(Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT)
            @player.dont_move
        end 
        
        #
        #   Jumping
        #
        if (Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0) and !$player_in_air
            @player.jump
        end

        #
        #   shoot
        #
        if Gosu.button_down? Gosu::KB_SPACE and !$shot_on_cooldown
            @Projectile.shoot
        end

            @player.going_to_collide
            @player.move
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
