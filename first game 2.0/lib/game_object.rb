


class Game_object
    attr_accessor :x, :y
    def initialize
        @x = x
        @y = y



        

    end

    def hitbox
        

    end

    def project(collision, projection_distance, angle)
        if collision
            @x += Gosu::offset_x(angle, projection_distance)
            @y += Gosu::offset_y(angle, projection_distance)
        end
    end

    #   moves the object with the current speed at an angle
    def move(angle, speed)
        @x += Gosu::offset_x(angle, speed)
        @y += Gosu::offset_y(angle, speed)
    end

    #   calculates angle of attacks and movement
    def facing_direction



    end

    
    

end