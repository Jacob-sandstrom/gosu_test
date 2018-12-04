

class Player
    def initialize
        @character = Gosu::Image.new("../img/circle.png")
        @basic_atk = Gosu::Image.new("../img/slash.png")
        $player_x, $player_y = $spawnpoint
        @face_dir_angle = 0
        @attack_dir = @face_dir_angle
        
        $attack_on_cooldown = false
        @attack_cooldown = 2
        @attack_display_time = 0.00001

        @cooldown_start_time = Gosu.milliseconds

        @x_direction = 0
        @y_direction = 0
        @speed = 4
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
        if @attack_display_time >= Gosu.milliseconds / 1000 - @cooldown_start_time
            return true
        else 
            return false
        end
    end
    
    def attack
        @cooldown_start_time = Gosu.milliseconds / 1000
        $attack_on_cooldown = true

        @attack_dir = @face_dir_angle
    end



    def move
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
    end


    def draw
        @character.draw($player_x, $player_y, 10, scale_x = 1, scale_y = 1, color = 0x9f_ffffff)
        
        
        if Gosu.milliseconds / 1000 - @cooldown_start_time >= @attack_cooldown
            $attack_on_cooldown = false
        end

        
        
        facing_direction
        if display_attack
            @basic_atk.draw_rot($player_x + 16, $player_y + 16, 9, @attack_dir, center_x = 0.5, center_y = 0.75)
        end
    end


end