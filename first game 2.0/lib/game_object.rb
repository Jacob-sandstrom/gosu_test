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
        @x_dir = 0
        @y_dir = 0
        
        @action_handler = Action_handler.new(action_data)
        
    end



    def project(collision, projection_distance, angle)
        if collision
            @x += Gosu::offset_x(angle, projection_distance)
            @y += Gosu::offset_y(angle, projection_distance)
        end
    end


    #   calculates angle of attacks and movement
    def direction
        if @x_dir == 0 && @y_dir == 0
            @y_vel = 0
            @x_vel = 0
        else
            @move_angle = Math.atan2(@y_dir, @x_dir)
            @y_vel = Math.sin(@move_angle)
            @x_vel = Math.cos(@move_angle)
        end

    end

    def move
        @x += @x_vel
        @y += @y_vel
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