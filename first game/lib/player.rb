

class Player
    def initialize
        @character = Gosu::Image.new("../img/circle.png")
        @basic_atk = Gosu::Image.new("../img/slash.png")
        $player_x, $player_y = $spawnpoint
        @face_dir_angle = 0
        @attack_dir = @face_dir_angle
        
        $attack_on_cooldown = false
        @attack_cooldown = 500
        @attack_display_time = 100
        @cooldown_start_time = 0.0

        @x_direction = 0
        @y_direction = 0
        @speed = 4


        @knockback_angle = 0
        @knockback_distance = 20
        @knockback = @knockback_distance

        @shielding = false
        @perfect_shielding_duration = 200
        @shield_start_time = 0

        @health = 5
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

    def facing_direction
        
        case @x_direction 
        when 1
            @face_dir_angle = 90
        when -1 
            @face_dir_angle = 270
        when 0 
            case @y_direction
            when 1
                @face_dir_angle = 180
            when -1
                @face_dir_angle = 0
            end
        end

        return @face_dir_angle
    end

    def display_attack
        if @attack_display_time >= Gosu.milliseconds  - @cooldown_start_time
            return true
        else 
            return false
        end
    end
    
    def attack
        @cooldown_start_time = Gosu.milliseconds
        $attack_on_cooldown = true

        @attack_dir = @face_dir_angle
    end

    def attack_collision
        return display_attack, @attack_dir
    end

    def is_shielding

        if (@perfect_shielding_duration >= Gosu::milliseconds -  @shield_start_time) && @shielding
            @perfect_shielding = true
        else
            @perfect_shielding = false
        end 

    end

    def shield
        unless @shielding
            @shield_start_time = Gosu::milliseconds
        end

        @shielding = true
        
    end
    def dont_shield
        @shielding = false
    end

    def damage(multiplier)
        @health -= 1 * multiplier
    end

    def knocked_back
        $player_x += Gosu::offset_x(@knockback_angle, @knockback)
        $player_y += Gosu::offset_y(@knockback_angle, @knockback)

        @knockback *= 0.8
    end


    def hit(angle)
        if @perfect_shielding
            damage(0)
            @knockback_angle = angle
            @knockback = 0
        elsif @shielding
            damage(0.5)
            @knockback_angle = angle
            @knockback = @knockback_distance / 2
        else
            damage(1)
            @knockback_angle = angle
            @knockback = @knockback_distance

        end
    end


    def move
        unless @health <= 0
            if @x_direction == -1 && @y_direction == 1
                $player_x += Gosu.offset_x(225, @speed)
                $player_y += Gosu.offset_y(225, @speed)
            elsif @x_direction == 1 && @y_direction == 1
                $player_x += Gosu.offset_x(135, @speed)
                $player_y += Gosu.offset_y(135, @speed)
            elsif @x_direction == 1 && @y_direction == -1
                $player_x += Gosu.offset_x(45, @speed)
                $player_y += Gosu.offset_y(45, @speed)
            elsif @x_direction == -1 && @y_direction == -1
                $player_x += Gosu.offset_x(315, @speed)
                $player_y += Gosu.offset_y(315, @speed)
            else
                $player_x += @x_direction * @speed
                $player_y += @y_direction * @speed
            end
            
            $player_x %= 1000
            $player_y %= 700

            knocked_back
            is_shielding
        end
    end


    def draw
        unless @health <= 0
            @character.draw($player_x, $player_y, 10, scale_x = 1, scale_y = 1, color = 0x9f_ffffff)
            
            
            if Gosu.milliseconds - @cooldown_start_time >= @attack_cooldown
                $attack_on_cooldown = false
            end
            
            facing_direction
            if display_attack
                @basic_atk.draw_rot($player_x + 16, $player_y + 16, 9, @attack_dir, center_x = 0.5, center_y = 0.75)
            end
        end

        $font.draw(@perfect_shielding, 200, 200, 0, scale_x = 2, scale_y = 2, color = 0xff_00ff00)
        
    end


end