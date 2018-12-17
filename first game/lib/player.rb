

class Player
    def initialize
        @animation_frames = Gosu::Image.load_tiles("../img/example sprite sheet.png", 64, 64, tileable: true)

        @walk_down = @animation_frames[0..3]
        @walk_left = @animation_frames[4..7]
        @walk_right = @animation_frames[8..11]
        @walk_up = @animation_frames[12..15]
        @current_frame = @animation_frames[0]

        @current_frames_dir = @walk_down

        @frame_display_time = 100
        @frame_display_start = 0
        @frame_i = 0


        @character = Gosu::Image.new("../img/circle.png")
        @basic_atk = Gosu::Image.new("../img/slash.png")
        @shield_img = Gosu::Image.new("../img/shield.png")
        @shield_down = Gosu::Image.new("../img/shield_down.png")
        
        # @light = Gosu::Image.new("../img/lighttest.png", tileable: true)


        $player_x, $player_y = $spawnpoint
        @face_dir_angle = 0
        @attack_dir = @face_dir_angle
        
        $attack_on_cooldown = false
        @attack_cooldown = 500
        @attack_display_time = 100
        @cooldown_start_time = 0.0

        @x_direction = 0
        @y_direction = 0
        @speed = 5


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
            @current_frames_dir = @walk_right
        when -1 
            @face_dir_angle = 270
            @current_frames_dir = @walk_left
        when 0 
            case @y_direction
            when 1
                @face_dir_angle = 180
                @current_frames_dir = @walk_down
            when -1
                @face_dir_angle = 0
                @current_frames_dir = @walk_up
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
            @sheild_dir = @face_dir_angle
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

        @knockback_angle = angle
        needed_blocking_angle = angle - 180
        needed_blocking_angle %= 360
        
        if @perfect_shielding && needed_blocking_angle == @sheild_dir
            damage(0)
            @knockback = 0
        elsif @shielding && needed_blocking_angle == @sheild_dir
            damage(0.5)
            @knockback = @knockback_distance / 2
        else
            damage(1)
            @knockback = @knockback_distance
        end
    end

    def dont_shield_if_attacking
        if display_attack
            @shielding = false
        end
    end

    def update_frame
        
        if @x_direction == 0 && @y_direction == 0
            @current_frame = @current_frames_dir[0]
            @frame_i = 0
        elsif @frame_display_time <= Gosu.milliseconds - @frame_display_start
            @frame_i += 1
            @frame_i %= 4
            @frame_display_start = Gosu.milliseconds
            @current_frame = @current_frames_dir[@frame_i]
        end
    end

    def project(collision, axis, projection)

        if collision
            if axis == "x"
                $player_x -= projection
            else
                $player_y -= projection
            end
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
            
            # $player_x %= 1000
            # $player_y %= 700

            knocked_back
            is_shielding
            facing_direction


            if Gosu.milliseconds - @cooldown_start_time >= @attack_cooldown
                $attack_on_cooldown = false
            end

            dont_shield_if_attacking


            update_frame
        end
    end


    def draw
        unless @health <= 0
            # @character.draw($player_x - $cam_x, $player_y - $cam_y, 10, scale_x = 1, scale_y = 1)
            # i = 0
            # while i < 16
            #     @animation_frames[i].draw($player_x - $cam_x + i*64, $player_y - $cam_y, 10, scale_x = 1, scale_y = 1)
            #     i += 1
            # end

            @current_frame.draw($player_x - $cam_x, $player_y - $cam_y, 10, scale_x = 1, scale_y = 1)
            
            
            if display_attack
                @basic_atk.draw_rot($player_x + 32 - $cam_x, $player_y + 32 - $cam_y, 9, @attack_dir, center_x = 0.5, center_y = 0.75)
            end

            if @shielding
                @shield_down.draw_rot($player_x + 31 - $cam_x, $player_y + 64 - $cam_y, 11, @sheild_dir, center_x = 0.5, center_y = 0.5, scale_x = 2, scale_y = 2)
            end


            # @light.draw($player_x - 32 - $cam_x, $player_y - 32 - $cam_y, 100, 1, 1, color = 0x7f_ffffff)


        end

        # $font.draw(@perfect_shielding, 200, 200, 0, scale_x = 2, scale_y = 2, color = 0xff_00ff00)
        
    end


end