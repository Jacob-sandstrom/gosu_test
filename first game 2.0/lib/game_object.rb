require_relative 'action_handler.rb'
require_relative 'hitbox_shower.rb'


class Game_object
    attr_accessor :action_data, :x, :y
    def initialize(action_data, x=0, y=0)
        @x = x
        @y = y
        @move_angle = 0
        @move_speed = 2
        @x_vel = 0
        @y_vel = 0
        @x_dir = 0
        @y_dir = 0
        
        @action_handler = Action_handler.new(action_data)
        @hitbox_shower = Hitbox_shower.new(@action_handler)
        @show_hitboxes = false
        
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
            if @action_handler.allow_move
                @y_vel += Math.sin(@move_angle) * @move_speed
                @x_vel += Math.cos(@move_angle) * @move_speed
            end
        end

    end

    def action_move
        @x_vel += @action_handler.x_move
        @y_vel += @action_handler.y_move
    end

    def move
        @x += @x_vel
        @y += @y_vel
    end

    def update
        @x_vel = 0
        @y_vel = 0

        direction
        action_move
        move
        @action_handler.update(@x, @y)
    end

    def draw(window)
        @action_handler.draw(window, @x, @y)

        if @show_hitboxes
            @hitbox_shower.draw(window, @x, @y)
        end
    end

    
    

end