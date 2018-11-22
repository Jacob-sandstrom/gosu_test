require 'gosu'


class Collision_detection
    def initialize


    end

    def to_left?(object1_center_x, object2_center_x)
        
        if object1_center_x <= object2_center_x
            to_left = true
        else 
            to_left = false
        end
        return to_left
    end

    def above?(object1_center_y, object2_center_y)

        if object1_center_y <= object2_center_y
            above = true
        else 
            above = false
        end
        return above
        
    end

    def up_left_collision

    end
    
    def collide?(object1_x, object1_y, object1_width, object1_height, object2_x, object2_y, object2_width, object2_height)

        
        #   intermediate storage
        object1_center_x = object1_x + object1_width / 2
        object1_center_y = object1_y + object1_height / 2
        object2_center_x = object2_x + object2_width / 2
        object2_center_y = object2_y + object2_height / 2

        #   intermediate storage
        object1_right_x = object1_x + object1_width
        object1_bottom_y = object1_y + object1_height
        object2_right_x = object2_x + object2_width
        object2_bottom_y = object2_y + object2_height




        to_left = to_left?(object1_center_x, object2_center_x)
        above = above?(object1_center_y, object2_center_y)

        #   Is object1 to the topleft, topright, bottomleft och bottomright of object2?
        case above
        when true
            case to_left
            when true

            when false

            end
        when false
            case to_left
            when true

            when false

            end
        end

    end



end


class Object
    def initialize
        @image = Gosu::Image.new("../img/platform.png")

        $platform_x = 100
        $platform_y = 500

    end



    def draw
        @image.draw($platform_x, $platform_y, 0)

    end

end

class Player
    def initialize
        @image = Gosu::Image.new("../img/CharacterSquare.png")

        $player_x = $width / 2
        $player_y = 568
        
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
        
        $shot_on_cooldown = false
        @shot_speed = 20
        @shot_iterations = 0
        @cooldown_timer = 0
        @cooldown = 10

    end

    def angle

        @current_angle = (Math.atan2(($player_y - $mouse_y), ($player_x - $mouse_x)) * 180 / Math::PI - 90)

    end


    def shoot
        $projectile_x[@shot_iterations] = $player_x
        $projectile_y[@shot_iterations] = $player_y
        @angle[@shot_iterations] = @current_angle
        @shot_iterations += 1
        @shot_iterations %= @max_shots
        $shot_on_cooldown = true
        # @pew.play
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

        @move_iterations = 0
        while @move_iterations < @max_shots
            angle = @angle[@move_iterations]
            $projectile_x[@move_iterations] += Gosu.offset_x(angle, @shot_speed)
            $projectile_y[@move_iterations] += Gosu.offset_y(angle, @shot_speed)
            @move_iterations += 1
        end

        
    end

    def draw

        @draw_iterations = 0
        while @draw_iterations < @max_shots
            @image.draw_rot($projectile_x[@draw_iterations] + 16, $projectile_y[@draw_iterations] + 16, 0, @angle[@draw_iterations], center_x = 0.5, center_y = 0.5)
            @draw_iterations += 1
        end

    end

end

class Gosu_test < Gosu::Window
    def initialize
        $width = 800
        $height = 600
        super $width, $height
        self.caption = "Shoot stuff"

        
        @Projectile = Projectile.new
        @player = Player.new
        @object = Object.new

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

        @object.draw
        @Projectile.draw
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