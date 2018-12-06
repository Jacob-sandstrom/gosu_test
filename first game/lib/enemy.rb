require_relative 'collision_detection.rb'


class Enemy
    def initialize
        @collision_detection = Collision_detection.new
        @image = Gosu::Image.new("../img/enemy2.png")
        @attack_img = Gosu::Image.new("../img/block.png")

        $enemy_x, $enemy_y = $enemy_spawn
        @health = 5

        @x_direction = 0
        @y_direction = 0
        @speed = 5
        # @wait_between_moves = 2000
        @attack_charge_time = 500
        @attack_charge_start = 0
        @attack_range = 32
        @cooldown_after_attacking = 500

        @knockback_angle = 0
        @knockback_distance = 20
        @knockback = @knockback_distance

        @attack_lifetime = 300
        @display_attack = false
        @attack_start_life = 0
        @charging_attack = false
        

        @absolute_angle = 0
    end

    def damage
        @health -= 1
    end

    def knocked_back
        $enemy_x += Gosu::offset_x(@knockback_angle, @knockback)
        $enemy_y += Gosu::offset_y(@knockback_angle, @knockback)

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

    def execute_attack
        @attack_start_life = Gosu.milliseconds
        @display_attack = true
        @charging_attack = false
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
        
        $enemy_x += Gosu::offset_x(angle, @speed)
        $enemy_y += Gosu::offset_y(angle, @speed)
    end


    def ai
        angle = (Math.atan2(($player_y + 16 - ($enemy_y + 32)), ($player_x + 16 - ($enemy_x + 32))) * 180 / Math::PI - 90) -180
        angle %= 360
        collision, projection_distance, a = @collision_detection.circle_with_box_collison($player_x-16, $player_y-16, @attack_range, $enemy_x, $enemy_y, 64, 64)
        unless @charging_attack || on_cooldown_after_attack
            if collision
                attack(angle)
            else
                move(angle)
            end
        end

    end


    def update
        unless @health <= 0



            ai

            if @charging_attack
                charge_attack
            end

            knocked_back

            stop_displaying_attack
        end
    end

    def draw
        unless @health <= 0
            @image.draw($enemy_x, $enemy_y, 8)
            
            if @display_attack
                @attack_img.draw($enemy_x + 16 + Gosu::offset_x(@absolute_angle, 64), $enemy_y + 16 + Gosu::offset_y(@absolute_angle, 64), 8)
            end
            
        end
    end


end