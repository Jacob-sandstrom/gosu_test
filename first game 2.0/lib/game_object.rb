require_relative 'action_handler.rb'


class Game_object
    attr_accessor :action_data, :x, :y
    def initialize(action_data, x=0, y=0)
        @x = x
        @y = y
        @move_angle = 0
        @move_speed = 10
        @x_vel = 0
        @y_vel = 0
        
        @action_handler = Action_handler.new(action_data)
        
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
    def direction
        @move_angle = Math.atan2(@y_vel, @x_vel) * 180 / Math::PI

    end

    def move
        @x += Gosu::offset_x(@move_angle, @move_speed)
        @y += Gosu::offset_y(@move_angle, @move_speed)
    end

    def update
        @x_vel = 0
        @y_vel = 0

        direction
        move
        @action_handler.update(@x, @y)
    end

    def draw
        @action_handler.draw(@x, @y)
    end

    
    

end