class Collision_detection
    def initialize


    end

    #   Where is object1 in relation to object2
    def to_left?(object1_center_x, object2_center_x)
        
        if object1_center_x <= object2_center_x
            to_left = true
        else 
            to_left = false
        end
        return to_left
    end

    def above?(object1_center_y, object2_center_y)

        if object1_center_y <= object2_center_y
            above = true
        else 
            above = false
        end
        return above
        
    end

    #   Is a collision happening and where?
    def up_left_collision(object1_right_x, object1_bottom_y, object2_x, object2_y)
        if object1_right_x > object2_x && object1_bottom_y > object2_y
            up_left_collision = true
        else 
            up_left_collision = false
        end
        return up_left_collision
    end
    def up_right_collision(object1_x, object1_bottom_y, object2_right_x, object2_y)
        if object1_x < object2_right_x && object1_bottom_y > object2_y
            up_right_collision = true
        else 
            up_right_collision = false
        end
        return up_right_collision
    end
    def down_left_collision(object1_right_x, object1_y, object2_x, object2_bottom_y)
        if object1_right_x > object2_x && object1_y < object2_bottom_y
            down_left_collision = true
        else 
            down_left_collision = false
        end
        return down_left_collision
    end
    def down_right_collision(object1_x, object1_y, object2_right_x, object2_bottom_y)
        if object1_x < object2_right_x && object1_y < object2_bottom_y
            down_right_collision = true
        else 
            down_right_collision = false
        end
        return down_right_collision
    end

    #   Direction to project
    def up_or_left_projektion?(object1_right_x, object1_bottom_y, object2_x, object2_y)
        x_difference = object1_right_x - object2_x
        y_difference = object1_bottom_y - object2_y

        if x_difference <= y_difference
            out = "x"
        else
            out = "y"
        end
        return out
    end
    def up_or_right_projektion?(object1_x, object1_bottom_y, object2_right_x, object2_y)
        x_difference = object2_right_x - object1_x
        y_difference = object1_bottom_y - object2_y
        
        if x_difference <= y_difference
            out = "x"
        else
            out = "y"
        end
        return out
    end
    def down_or_left_projektion?(object1_right_x, object1_y, object2_x, object2_bottom_y)
        x_difference = object1_right_x - object2_x
        y_difference = object2_bottom_y - object1_y
        
        if x_difference <= y_difference
            out = "x"
        else
            out = "y"
        end
        return out
    end
    def down_or_right_projektion?(object1_x, object1_y, object2_right_x, object2_bottom_y)
        x_difference = object2_right_x - object1_x
        y_difference = object2_bottom_y - object1_y
        
        if x_difference <= y_difference
            out = "x"
        else
            out = "y"
        end
        return out
    end

    #   Projection
    def project_left(object1_right_x, object2_x)
        projection = object1_right_x - object2_x
        return projection
    end
    def project_up(object1_bottom_y, object2_y)
        projection = object1_bottom_y - object2_y
        return projection
    end
    def project_right(object1_x, object2_right_x)
        projection = object1_x - object2_right_x
        return projection
    end
    def project_down(object1_y, object2_bottom_y)
        projection = object1_y - object2_bottom_y
        return projection
    end

    
    #
    #   Main collision function
    #
    def collide?(object1_x, object1_y, object1_width, object1_height, object2_x, object2_y, object2_width, object2_height)

        #   intermediate storage
        object1_center_x = object1_x + object1_width / 2
        object1_center_y = object1_y + object1_height / 2
        object2_center_x = object2_x + object2_width / 2
        object2_center_y = object2_y + object2_height / 2

        #   intermediate storage
        object1_right_x = object1_x + object1_width
        object1_bottom_y = object1_y + object1_height
        object2_right_x = object2_x + object2_width
        object2_bottom_y = object2_y + object2_height


        to_left = to_left?(object1_center_x, object2_center_x)
        above = above?(object1_center_y, object2_center_y)

        #   Is object1 to the topleft, topright, bottomleft och bottomright of object2? And check for collision there.
        case above
        when true
            case to_left
            when true
                up_left_collision = up_left_collision(object1_right_x, object1_bottom_y, object2_x, object2_y)
                collision = up_left_collision
            when false
                up_right_collision = up_right_collision(object1_x, object1_bottom_y, object2_right_x, object2_y)
                collision = up_right_collision
            end
        when false
            case to_left
            when true
                down_left_collision = down_left_collision(object1_right_x, object1_y, object2_x, object2_bottom_y)
                collision = down_left_collision
            when false
                down_right_collision = down_right_collision(object1_x, object1_y, object2_right_x, object2_bottom_y)
                collision = down_right_collision
            end
        end

        #   Find out wich direction to project and how much to project
        case true
        when up_left_collision
            x_or_y = up_or_left_projektion?(object1_right_x, object1_bottom_y, object2_x, object2_y)
            if x_or_y == "x"
                projection = project_left(object1_right_x, object2_x)
            else
                projection = project_up(object1_bottom_y, object2_y)
            end
        when up_right_collision
            x_or_y = up_or_right_projektion?(object1_x, object1_bottom_y, object2_right_x, object2_y)
            if x_or_y == "x"
                projection = project_right(object1_x, object2_right_x)
            else
                projection = project_up(object1_bottom_y, object2_y)
            end
        when down_left_collision
            x_or_y = down_or_left_projektion?(object1_right_x, object1_y, object2_x, object2_bottom_y)
            if x_or_y == "x"
                projection = project_left(object1_right_x, object2_x)
            else
                projection = project_down(object1_y, object2_bottom_y)
            end
        when down_right_collision
            x_or_y = down_or_right_projektion?(object1_x, object1_y, object2_right_x, object2_bottom_y)
            if x_or_y == "x"
                projection = project_right(object1_x, object2_right_x)
            else
                projection = project_down(object1_y, object2_bottom_y)
            end
        else
            collision = false
        end
        
        #   Returns if a collision has happened, on which axis it should be projected and how much is should be projected
        return collision, x_or_y, projection
        
    end

    def up_left_circle_box_collision(object1_center_x, object1_center_y, object1_radius, object2_x, object2_y)
        if object1_center_x >= object2_x && object1_bottom_y > object2_y
            up_left_collision = true
        else 
            up_left_collision = false
        end
        return up_left_collision
    end
    def up_right_circle_box_collision(object1_center_x, object1_center_y, object1_radius, object2_right_x, object2_y)
        if object1_x < object2_right_x && object1_bottom_y > object2_y
            up_right_collision = true
        else 
            up_right_collision = false
        end
        return up_right_collision
    end
    def down_left_circle_box_collision(object1_center_x, object1_center_y, object1_radius, object2_x, object2_bottom_y)
        if object1_right_x > object2_x && object1_y < object2_bottom_y
            down_left_collision = true
        else 
            down_left_collision = false
        end
        return down_left_collision
    end
    def down_right_circle_box_collision(object1_center_x, object1_center_y, object1_radius, object2_right_x, object2_bottom_y)
        if object1_x < object2_right_x && object1_y < object2_bottom_y
            down_right_collision = true
        else 
            down_right_collision = false
        end
        return down_right_collision
    end

    def circle_with_box_collison(object1_x, object1_y, object1_radius, object2_x, object2_y, object2_width, object2_height)

        #   intermediate storage
        object1_center_x = object1_x + object1_radius / 2
        object1_center_y = object1_y + object1_radius / 2
        object2_center_x = object2_x + object2_width / 2
        object2_center_y = object2_y + object2_height / 2

        #   intermediate storage
        object2_right_x = object2_x + object2_width
        object2_bottom_y = object2_y + object2_height


        to_left = to_left?(object1_center_x, object2_center_x)
        above = above?(object1_center_y, object2_center_y)

        #   Is object1 to the topleft, topright, bottomleft och bottomright of object2? And check for collision there.
        case above
        when true
            case to_left
            when true
                up_left_collision = up_left_collision(object1_right_x, object1_bottom_y, object2_x, object2_y)
                collision = up_left_collision
            when false
                up_right_collision = up_right_collision(object1_x, object1_bottom_y, object2_right_x, object2_y)
                collision = up_right_collision
            end
        when false
            case to_left
            when true
                down_left_collision = down_left_collision(object1_right_x, object1_y, object2_x, object2_bottom_y)
                collision = down_left_collision
            when false
                down_right_collision = down_right_collision(object1_x, object1_y, object2_right_x, object2_bottom_y)
                collision = down_right_collision
            end
        end

        #   Find out wich direction to project and how much to project
        case true
        when up_left_collision
            x_or_y = up_or_left_projektion?(object1_right_x, object1_bottom_y, object2_x, object2_y)
            if x_or_y == "x"
                projection = project_left(object1_right_x, object2_x)
            else
                projection = project_up(object1_bottom_y, object2_y)
            end
        when up_right_collision
            x_or_y = up_or_right_projektion?(object1_x, object1_bottom_y, object2_right_x, object2_y)
            if x_or_y == "x"
                projection = project_right(object1_x, object2_right_x)
            else
                projection = project_up(object1_bottom_y, object2_y)
            end
        when down_left_collision
            x_or_y = down_or_left_projektion?(object1_right_x, object1_y, object2_x, object2_bottom_y)
            if x_or_y == "x"
                projection = project_left(object1_right_x, object2_x)
            else
                projection = project_down(object1_y, object2_bottom_y)
            end
        when down_right_collision
            x_or_y = down_or_right_projektion?(object1_x, object1_y, object2_right_x, object2_bottom_y)
            if x_or_y == "x"
                projection = project_right(object1_x, object2_right_x)
            else
                projection = project_down(object1_y, object2_bottom_y)
            end
        else
            collision = false
        end
        
        #   Returns if a collision has happened, on which axis it should be projected and how much is should be projected
        return collision, x_or_y, projection
        
    end


    def up_left_adjacent(object1_right_x, object1_bottom_y, object2_x, object2_y)
        if object1_right_x > object2_x && object1_bottom_y == object2_y
            adjacent = "down_adjacent"
        elsif object1_right_x == object2_x && object1_bottom_y > object2_y
            adjacent = "right_adjacent" 
        else
            adjacent = "none"
        end
        return adjacent
    end
    def up_right_adjacent(object1_x, object1_bottom_y, object2_right_x, object2_y)
        if object1_x < object2_right_x && object1_bottom_y == object2_y
            adjacent = "down_adjacent"
        elsif object1_x == object2_right_x && object1_bottom_y > object2_y
            adjacent = "left_adjacent"
        else
            adjacent = "none"
        end
        return adjacent
    end
    def down_left_adjacent(object1_right_x, object1_y, object2_x, object2_bottom_y)
        if object1_right_x > object2_x && object1_y == object2_bottom_y
            adjacent = "up_adjacent" 
        elsif object1_right_x == object2_x && object1_y < object2_bottom_y
            adjacent = "right_adjacent"
        else
            adjacent = "none"
        end
        return adjacent
    end
    def down_right_adjacent(object1_x, object1_y, object2_right_x, object2_bottom_y)
        if object1_x < object2_right_x && object1_y == object2_bottom_y
            adjacent = "up_adjacent"
        elsif object1_x == object2_right_x && object1_y < object2_bottom_y
            adjacent = "left_adjacent" 
        else
            adjacent = "none"
        end
        return adjacent
    end

    def is_adjacent(object1_x, object1_y, object1_width, object1_height, object2_x, object2_y, object2_width, object2_height)

        #   intermediate storage
        object1_center_x = object1_x + object1_width / 2
        object1_center_y = object1_y + object1_height / 2
        object2_center_x = object2_x + object2_width / 2
        object2_center_y = object2_y + object2_height / 2

        #   intermediate storage
        object1_right_x = object1_x + object1_width
        object1_bottom_y = object1_y + object1_height
        object2_right_x = object2_x + object2_width
        object2_bottom_y = object2_y + object2_height


        to_left = to_left?(object1_center_x, object2_center_x)
        above = above?(object1_center_y, object2_center_y)

        #   Is object1 to the topleft, topright, bottomleft och bottomright of object2? And check for collision there.
        case above
        when true
            case to_left
            when true
                adjacent = up_left_adjacent(object1_right_x, object1_bottom_y, object2_x, object2_y)
            when false
                adjacent = up_right_adjacent(object1_x, object1_bottom_y, object2_right_x, object2_y)
            end
        when false
            case to_left
            when true
                adjacent = down_left_adjacent(object1_right_x, object1_y, object2_x, object2_bottom_y)
            when false
                adjacent = down_right_adjacent(object1_x, object1_y, object2_right_x, object2_bottom_y)
            end
        end

        return adjacent

    end

end