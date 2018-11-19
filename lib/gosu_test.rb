require 'gosu'




class Player
    def initialize
        @image = Gosu::Image.new("../img/CharacterSquare.png")
        
        @direction = 0
        @speed = 4
        
        @grav = 1.5
        @default_jump_speed = 20
        @jump_speed = @default_jump_speed
        @in_air = false
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
      @in_air = true
      @jump_speed = @default_jump_speed

    end

    def in_the_air
        return @in_air
    end

    def x_location
        return @x
    end

    def y_location
        return @y
    end

    def going_to_collide

        if $player_y >= 568 and $player_y != 568
            @in_air = false
            @jump_speed = 0
            $player_y = 568

        end
        

    end

    def update

        

        
    end
    
    def move

        


      $player_x += @direction * @speed
      $player_x %= 800
      
      if @in_air
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
        $projectile_x = 0
        $projectile_y = 0


    end


    def shoot
        $projectile_x = $player_x
        $projectile_y = $player_y
    end

    def move
        $projectile_x += 10
    end

    def draw
        @image.draw($projectile_x, $projectile_y, 0)
        
    end

end

class Gosu_test < Gosu::Window
    def initialize
        width = 800
        height = 600
        $player_x = width / 2
        $player_y = 568
        super width, height
        self.caption = "Gosu test"

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
        if (Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0) and !@player.in_the_air
            @player.jump
        end

        #
        #   shoot
        #
        if Gosu.button_down? Gosu::KB_SPACE
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
