#
#   TODO IF ADDED TO NEW GAME
#
#   @projectile = Projectile.new

# $mouse_x = mouse_x
# $mouse_y = mouse_y

# @projectile.update_shot

# @projectile.draw

# if Gosu.button_down? Gosu::MS_LEFT and !$shot_on_cooldown
#     @projectile.shoot
# end

# make sure player positions are $player_y, $player_x




class Projectile
    def initialize
        @image = Gosu::Image.new("../img/shipTransparent.png")
        @pew = Gosu::Sample.new("../sound/Pew.wav")


        $projectile_width = 32
        $projectile_height = 32

        $max_shots = 20
        $projectile_x = Array.new($max_shots, 0)
        $projectile_y = Array.new($max_shots, -50)
        @angle        = Array.new($max_shots, 0)
        
        $shot_on_cooldown = false
        @shot_speed = 10
        @shot_iterations = 0
        @cooldown_timer = 0
        @cooldown = 10

    end

    def angle

        @current_angle = (Math.atan2(($player_y + 16 - $mouse_y), ($player_x + 16 - $mouse_x)) * 180 / Math::PI - 90)

    end

    def shoot
        $projectile_x[@shot_iterations] = $player_x
        $projectile_y[@shot_iterations] = $player_y
        @angle[@shot_iterations] = @current_angle
        @shot_iterations += 1
        @shot_iterations %= $max_shots
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

    def destroy_all_shots
        i = 0
        while i < $max_shots
            $projectile_x[i] = nil
            $projectile_y[i] = nil
            i += 1
        end
    end

    def destroy_shot(shot_num)
        $projectile_x[shot_num] = nil
        $projectile_y[shot_num] = nil
    end

    def move

        @move_iterations = 0
        while @move_iterations < $max_shots
            angle = @angle[@move_iterations]
            unless $projectile_x[@move_iterations] == nil || $projectile_y[@move_iterations] == nil
                $projectile_x[@move_iterations] += Gosu.offset_x(angle, @shot_speed)
                $projectile_y[@move_iterations] += Gosu.offset_y(angle, @shot_speed)
            end
            @move_iterations += 1
        end

        
    end

    def draw

        draw_iterations = 0
        while draw_iterations < $max_shots
            unless $projectile_x[draw_iterations] == nil || $projectile_y[draw_iterations] == nil
                @image.draw_rot($projectile_x[draw_iterations] + 16, $projectile_y[draw_iterations] + 16, 0, @angle[draw_iterations], center_x = 0.5, center_y = 0.5)
            end
            draw_iterations += 1
        end

    end

    def update_shot

        angle
        decrease_cooldown
        move

        i = 0
        while i < $max_shots
            unless $projectile_x[i] == nil || $projectile_y[i] == nil
                if $projectile_x[i] > 2000 || $projectile_x[i] < -50 || $projectile_y[i] > 1500 || $projectile_y[i] < -50
                    $projectile_x[i] = nil
                    $projectile_y[i] = nil
                end
            end
            i += 1
        end
    end

end
