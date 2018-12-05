require_relative 'collision_detection.rb'


class Enemy
    def initialize
        @collision_detection = Collision_detection.new
        @image = Gosu::Image.new("../img/enemy.png")

        $enemy_x, $enemy_y = $enemy_spawn
        @health = 2

        @x_direction = 0
        @y_direction = 0
        @speed = 1
        # @wait_between_moves = 2000
        @attack_charge_time = 2000
        @attack_range = 32


        
    end

    def damage
        @health -= 1
    end

    def closest_angle(angle)
        possible_angles = [(0 - angle).abs, (90 - angle).abs, (180 - angle).abs, (270 - angle).abs , (360 - angle).abs]
        min = possible_angles.min
        min_index = possible_angles.index(min)

        case min_index
        when 0 || 4
            definate_angle = 0
        when 1
            definate_angle = 90
        when 2 
            definate_angle = 180
        when 3
            definate_angle = 270
        end

        return definate_angle    
    end

    def attack(angle)
        definate_angle = closest_angle(angle)



        
    end

    def move(angle)
        
        $enemy_x += Gosu::offset_x(angle, @speed)
        $enemy_y += Gosu::offset_y(angle, @speed)
    end


    def ai
        angle = (Math.atan2(($player_y + 16 - ($enemy_y + 32)), ($player_x + 16 - ($enemy_x + 32))) * 180 / Math::PI - 90) -180
        collision, projection_distance, a = @collision_detection.circle_with_box_collison($player_x-16, $player_y-16, @attack_range, $enemy_x, $enemy_y, 64, 64)
        if collision
            attack(angle)
        else

            move(angle)


        end

        # return angle
    end


    def update

        ai
    end

    def draw
        # angle = ai
        # $font.draw(angle, 200, 200, 1, scale_x = 1, scale_y = 1, Gosu::Color::BLACK)
        unless @health <= 0
            @image.draw($enemy_x, $enemy_y, 8)
        end
    end

end