require_relative 'collision_detection.rb'


class Enemy
    def initialize
        @collision_detection = Collision_detection.new
        @image = Gosu::Image.new("../img/enemy2.png")
        @attack_img = Gosu::Image.new("../img/block.png")

        @enemy_x, @enemy_y = $enemy_spawn
        @health = 5

        @x_direction = 0
        @y_direction = 0
        @speed = 10
        # @wait_between_moves = 2000
        @attack_charge_time = 500
        @attack_charge_start = 0
        @attack_range = 32
        @cooldown_after_attacking = 500

        @knockback_angle = 0
        @knockback_distance = 20
        @knockback = @knockback_distance


        @attack_x = nil
        @attack_y = nil

        @attack_lifetime = 200
        @display_attack = false
        @attack_start_life = 0
        @charging_attack = false
        @attack_launch_speed = 15
        @attack_launch = @attack_launch_speed

        @absolute_angle = 0

        @activation_distance = 200
        @activated = false


        @angle = 0
    end

    def get_xy
        return [@enemy_x, @enemy_y]
    end

    def absolute_angle
        return @absolute_angle
    end

    def damage
        @health -= 1
    end

    def knocked_back
        @enemy_x += Gosu::offset_x(@knockback_angle, @knockback)
        @enemy_y += Gosu::offset_y(@knockback_angle, @knockback)

        @knockback *= 0.8
    end


    def hit(angle)
        damage
        @knockback_angle = angle
        @knockback = @knockback_distance
    end

    def closest_angle(angle)
        possible_angles = [(0 - angle).abs, (90 - angle).abs, (180 - angle).abs, (270 - angle).abs , (360 - angle).abs]
        min = possible_angles.min
        min_index = possible_angles.index(min)

        case min_index
        when 0 
            absolute_angle = 0
        when 4
            absolute_angle = 0
        when 1
            absolute_angle = 90
        when 2 
            absolute_angle = 180
        when 3
            absolute_angle = 270
        end

        return absolute_angle    
    end

    def stop_displaying_attack
        unless attack_still_alive?
            @display_attack = false
        end
    end

    def attack_still_alive?
        if @attack_lifetime >= Gosu.milliseconds - @attack_start_life 
            return true
        else
            return false
        end
    end

    def on_cooldown_after_attack
        if @cooldown_after_attacking >= Gosu.milliseconds - @attack_start_life
            return true
        else
            return false
        end


    end
    
    def player_hit?
        unless @attack_x == nil || @attack_y == nil
            collision, projection_distance, a = @collision_detection.circle_with_box_collison($player_x + 16, $player_y + 22, 16, @attack_x, @attack_y, 32, 32)

            if collision
                $player_hit = true
            end
        end
    end

    def execute_attack
        @attack_start_life = Gosu.milliseconds
        @display_attack = true
        @charging_attack = false
        @attack_launch = @attack_launch_speed
        # @attack_x = (@enemy_x + 16 + Gosu::offset_x(@absolute_angle, 64))
        # @attack_y = (@enemy_y + 16 + Gosu::offset_y(@absolute_angle, 64))
        case @absolute_angle
        when 0
            @attack_x = (@enemy_x + 16 + Gosu::offset_x(@absolute_angle, 64)) + 32
            @attack_y = (@enemy_y + 16 + Gosu::offset_y(@absolute_angle, 64))
        when 90
            @attack_x = (@enemy_x + 16 + Gosu::offset_x(@absolute_angle, 64))
            @attack_y = (@enemy_y + 16 + Gosu::offset_y(@absolute_angle, 64)) + 32
        when 180
            @attack_x = (@enemy_x + 16 + Gosu::offset_x(@absolute_angle, 64)) - 32
            @attack_y = (@enemy_y + 16 + Gosu::offset_y(@absolute_angle, 64))
        when 270
            @attack_x = (@enemy_x + 16 + Gosu::offset_x(@absolute_angle, 64))
            @attack_y = (@enemy_y + 16 + Gosu::offset_y(@absolute_angle, 64)) - 32
        end
    end
    
    def charge_attack
        if @attack_charge_time <= Gosu.milliseconds - @attack_start_charge
            execute_attack
        end
        
        
    end
    
    
    def attack(angle)
        @charging_attack = true
        @absolute_angle = closest_angle(angle)
        @attack_start_charge = Gosu.milliseconds
        
    end
    
    def move(angle)
        
        @enemy_x += Gosu::offset_x(angle, @speed)
        @enemy_y += Gosu::offset_y(angle, @speed)

    end
    
    def activate
        half = @activation_distance/2
        collision, projection_distance, a = @collision_detection.circle_with_box_collison($player_x + 32 - half, $player_y + 32 - half, @activation_distance, @enemy_x, @enemy_y, 64, 64)
        
        if collision
            @activated = true
        end
    end
    
    
    def ai
        unless @activated
            activate
        end
        
        if @activated
            angle = (Math.atan2(($player_y + 32 - (@enemy_y + 32)), ($player_x + 32 - (@enemy_x + 32))) * 180 / Math::PI - 90) -180
            angle %= 360
            @angle = angle
            collision, projection_distance, a = @collision_detection.circle_with_box_collison($player_x, $player_y, @attack_range, @enemy_x, @enemy_y, 64, 64)
            unless @charging_attack || on_cooldown_after_attack
                if collision
                    attack(angle)
                else
                    move(angle)
                end
                
            end
        end
        
    end
    
    def update_attack
        case @absolute_angle
        when 0
            @attack_x -= 5
        when 90
            @attack_y -= 5
        when 180
            @attack_x += 5
        when 270
            @attack_y += 5
        end
            
    end
    
    def update
        unless @health <= 0
            if @display_attack
                player_hit?
                update_attack
            end


            ai

            if @charging_attack
                charge_attack
            end

            knocked_back
            @enemy_x += Gosu::offset_x(@angle, @attack_launch)
            @enemy_y += Gosu::offset_y(@angle, @attack_launch)
            @attack_launch *= 0.8

            

            stop_displaying_attack
        end
    end

    def draw
        unless @health <= 0
            @image.draw(@enemy_x - $cam_x, @enemy_y - $cam_y, 8)
            
            if @display_attack
                @attack_img.draw(@attack_x - $cam_x, @attack_y - $cam_y, 8)
            end
            
        end
    end


end