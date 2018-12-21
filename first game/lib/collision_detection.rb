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
            angle = 270
        else
            angle = 0
        end
        return angle
    end
    def up_or_right_projektion?(object1_x, object1_bottom_y, object2_right_x, object2_y)
        x_difference = object2_right_x - object1_x
        y_difference = object1_bottom_y - object2_y
        
        if x_difference <= y_difference
            angle = 90
        else
            angle = 0
        end
        return angle
    end
    def down_or_left_projektion?(object1_right_x, object1_y, object2_x, object2_bottom_y)
        x_difference = object1_right_x - object2_x
        y_difference = object2_bottom_y - object1_y
        
        if x_difference <= y_difference
            angle = 270
        else
            angle = 180
        end
        return angle
    end
    def down_or_right_projektion?(object1_x, object1_y, object2_right_x, object2_bottom_y)
        x_difference = object2_right_x - object1_x
        y_difference = object2_bottom_y - object1_y
        
        if x_difference <= y_difference
            angle = 90
        else
            angle = 180
        end
        return angle
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
    def aabb_collision(object1_x, object1_y, object1_width, object1_height, object2_x, object2_y, object2_width, object2_height)

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
            angle = up_or_left_projektion?(object1_right_x, object1_bottom_y, object2_x, object2_y)
            if angle == 270
                projection = project_left(object1_right_x, object2_x)
            else
                projection = project_up(object1_bottom_y, object2_y)
            end
        when up_right_collision
            angle = up_or_right_projektion?(object1_x, object1_bottom_y, object2_right_x, object2_y)
            if angle == 90
                projection = project_right(object1_x, object2_right_x)
            else
                projection = project_up(object1_bottom_y, object2_y)
            end
        when down_left_collision
            angle = down_or_left_projektion?(object1_right_x, object1_y, object2_x, object2_bottom_y)
            if angle == 270
                projection = project_left(object1_right_x, object2_x)
            else
                projection = project_down(object1_y, object2_bottom_y)
            end
        when down_right_collision
            angle = down_or_right_projektion?(object1_x, object1_y, object2_right_x, object2_bottom_y)
            if angle == 90
                projection = project_right(object1_x, object2_right_x)
            else
                projection = project_down(object1_y, object2_bottom_y)
            end
        else
            collision = false
            projection = 0
        end
        
        absolute_projection = projection.abs

        #   Returns if a collision has happened, on which axis it should be projected and how much is should be projected
        return collision, absolute_projection, angle
        
    end

    def up_left_circle_box_collision(object1_center_x, object1_center_y, object1_radius, object2_x, object2_y)
        object1_right_x = object1_center_x + object1_radius
        object1_bottom_y = object1_center_y + object1_radius
        
        if object1_center_x < object2_x && object1_center_y < object2_y
            #   calculate angle and distance
            angle = (Math.atan2((object1_center_y - object2_y), (object1_center_x - object2_x)) * 180 / Math::PI - 90)
            distance_to_center = ((object1_center_x - object2_x)**2 + (object1_center_y - object2_y)**2)**0.5
            if distance_to_center - object1_radius < 0
                collision = true
                projection_distance = distance_to_center - object1_radius
                return collision, projection_distance, angle
            else 
                collision = false
            end
        elsif object1_center_x >= object2_x && object1_center_y + object1_radius > object2_y && object1_center_y < object2_y
            collision = true
            projection_distance = object1_center_y + object1_radius - object2_y
            angle = 0
        elsif object1_center_x + object1_radius > object2_x && object1_center_y >= object2_y && object1_center_x < object2_x
            collision = true
            projection_distance = object1_center_x + object1_radius - object2_x
            angle = 270
        elsif object1_center_x > object2_x && object1_center_y > object2_y
            collision = true
            if object1_center_y + object1_radius - object2_y < object1_center_x + object1_radius - object2_x
                projection_distance = object1_center_y + object1_radius - object2_y
                angle = 0
            else 
                object1_center_x + object1_radius - object2_x
                angle = 270
            end

        else
            collision = false
            projection_distance = nil
            angle = nil
        end
        return collision, projection_distance, angle
    end
    def up_right_circle_box_collision(object1_center_x, object1_center_y, object1_radius, object2_right_x, object2_y)
        if object1_center_x > object2_right_x && object1_center_y < object2_y
            #   calculate angle and distance
            angle = (Math.atan2((object1_center_y - object2_y), (object1_center_x - object2_right_x)) * 180 / Math::PI - 90)
            distance_to_center = ((object1_center_x - object2_right_x)**2 + (object1_center_y - object2_y)**2)**0.5
            if distance_to_center - object1_radius < 0
                collision = true
                projection_distance = distance_to_center - object1_radius
                return collision, projection_distance, angle
            else 
                collision = false
            end
        elsif object1_center_x <= object2_right_x && object1_center_y + object1_radius > object2_y && object1_center_y < object2_y
            collision = true
            projection_distance = object1_center_y + object1_radius - object2_y
            angle = 0
        elsif object1_center_x - object1_radius < object2_right_x && object1_center_y >= object2_y && object1_center_x > object2_right_x
            collision = true
            projection_distance = object2_right_x - object1_center_x + object1_radius
            angle = 90
        elsif object1_center_x < object2_right_x && object1_center_y > object2_y
            collision = true
            if object1_center_y + object1_radius - object2_y < object2_right_x - object1_center_x + object1_radius
                projection_distance = object1_center_y + object1_radius - object2_y
                angle = 0
            else 
                object2_right_x - object1_center_x + object1_radius
                angle = 90
            end
        else
            collision = false
            projection_distance = nil
            angle = nil
        end
        return collision, projection_distance, angle
    end
    def down_left_circle_box_collision(object1_center_x, object1_center_y, object1_radius, object2_x, object2_bottom_y)
        if object1_center_x < object2_x && object1_center_y > object2_bottom_y
            #   calculate angle and distance
            angle = (Math.atan2((object1_center_y - object2_bottom_y), (object1_center_x - object2_x)) * 180 / Math::PI - 90)
            distance_to_center = ((object1_center_x - object2_x)**2 + (object1_center_y - object2_bottom_y)**2)**0.5
            if distance_to_center - object1_radius < 0
                collision = true
                projection_distance = distance_to_center - object1_radius
                return collision, projection_distance, angle
            else 
                collision = false
            end
        elsif object1_center_x >= object2_x && object1_center_y - object1_radius < object2_bottom_y && object1_center_y > object2_bottom_y
            collision = true
            projection_distance = object2_bottom_y - object1_center_y + object1_radius
            angle = 180
        elsif object1_center_x + object1_radius > object2_x && object1_center_y <= object2_bottom_y && object1_center_x < object2_x
            collision = true
            projection_distance = object1_center_x + object1_radius - object2_x
            angle = 270
        elsif object1_center_x > object2_x && object1_center_y < object2_bottom_y
            collision = true
            if object2_bottom_y - object1_center_y + object1_radius < object1_center_x + object1_radius - object2_x
                projection_distance = object2_bottom_y - object1_center_y + object1_radius
                angle = 180
            else 
                object1_center_x + object1_radius - object2_x
                angle = 270
            end
        else
            collision = false
            projection_distance = nil
            angle = nil
        end
        return collision, projection_distance, angle
    end
    def down_right_circle_box_collision(object1_center_x, object1_center_y, object1_radius, object2_right_x, object2_bottom_y)
        if object1_center_x > object2_right_x && object1_center_y > object2_bottom_y
            #   calculate angle and distance
            angle = (Math.atan2((object1_center_y - object2_bottom_y), (object1_center_x - object2_right_x)) * 180 / Math::PI - 90)
            distance_to_center = ((object1_center_x - object2_right_x)**2 + (object1_center_y - object2_bottom_y)**2)**0.5
            if distance_to_center - object1_radius < 0
                collision = true
                projection_distance = distance_to_center - object1_radius
                return collision, projection_distance, angle
            else 
                collision = false
            end
        elsif object1_center_x <= object2_right_x && object1_center_y - object1_radius < object2_bottom_y && object1_center_y > object2_bottom_y
            collision = true
            projection_distance = object2_bottom_y - object1_center_y + object1_radius
            angle = 180
        elsif object1_center_x - object1_radius < object2_right_x && object1_center_y <= object2_bottom_y && object1_center_x > object2_right_x
            collision = true
            projection_distance = object2_right_x - object1_center_x + object1_radius
            angle = 90
        elsif object1_center_x < object2_right_x && object1_center_y < object2_bottom_y
            collision = true
            if object2_bottom_y - object1_center_y + object1_radius < object2_right_x - object1_center_x + object1_radius
                projection_distance = object2_bottom_y - object1_center_y + object1_radius
                angle = 180
            else 
                object2_right_x - object1_center_x + object1_radius
                angle = 90
            end
 

        else
            collision = false
            projection_distance = nil
            angle = nil
        end
        return collision, projection_distance, angle
    end

    def circle_with_box_collison(object1_x, object1_y, object1_radius, object2_x, object2_y, object2_width, object2_height)

        #   intermediate storage
        object1_center_x = object1_x + object1_radius 
        object1_center_y = object1_y + object1_radius 
        object2_center_x = object2_x + object2_width / 2
        object2_center_y = object2_y + object2_height / 2

        #   intermediate storage
        object2_right_x = object2_x + object2_width
        object2_bottom_y = object2_y + object2_height


        to_left = to_left?(object1_center_x, object2_center_x)
        above = above?(object1_center_y, object2_center_y)

        #   Is object1 to the topleft, topright, bottomleft och bottomright of object2? And check for collision there.
        #   Find out wich direction to project and how much to project
        case above
        when true
            case to_left
            when true
                collision, projection_distance, angle = up_left_circle_box_collision(object1_center_x, object1_center_y, object1_radius, object2_x, object2_y)
            when false
                collision, projection_distance, angle = up_right_circle_box_collision(object1_center_x, object1_center_y, object1_radius, object2_right_x, object2_y)
            end
        when false
            case to_left
            when true
                collision, projection_distance, angle = down_left_circle_box_collision(object1_center_x, object1_center_y, object1_radius, object2_x, object2_bottom_y)
            when false
                collision, projection_distance, angle = down_right_circle_box_collision(object1_center_x, object1_center_y, object1_radius, object2_right_x, object2_bottom_y)
            end
        end

        
        #   Returns if a collision has happened, on which angle it should be projected and how much is should be projected
        return collision, projection_distance, angle
        
    end



    def aabb_triangle_collision(object1_x, object1_y, object1_width, object1_height, object2_x, object2_y, object2_width, object2_height, hypotenuse_side)
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
        
        
        case hypotenuse_side
        when "up_left" 
            if above && to_left
                
            else
                #aabb
            end
            
        when "up_right" 
            # to_left = to_left?(object1_x, object2_x)
            # above = above?(object1_bottom_y, object2_bottom_y)
            # @aboveright = above && !to_left
            @aboveright = object1_x >= object2_x && object1_bottom_y <= object2_bottom_y

            @object1_x = object1_x
            @object2_x = object2_x
            @object1_bottom_y = object1_bottom_y
            @object2_bottom_y = object2_bottom_y

            # above && !to_left
            if object1_x >= object2_x && object1_bottom_y <= object2_bottom_y
                

                delta_y1 = object2_bottom_y - object2_y
                delta_x1 = object2_right_x - object2_x
                k1 = delta_y1 / delta_x1
                m1 = object2_bottom_y - (k1 * object2_right_x)

                k2 = -1/k1

                m2 = object1_bottom_y - (k2 * object1_x)

                intersect_x = (m2 - m1) / (k1 - k2)
                intersect_y = k1 * intersect_x + m1


                #if intersect_x > object2_x && intersect_x < object2_right_x && intersect_y > object2_y && intersect_y < object2_bottom_y

                    if intersect_x > object1_x && intersect_y < object1_bottom_y
                        collision = true
                        distance = (((intersect_x - object1_x) ** 2 + (object1_bottom_y - intersect_y) ** 2) ** (0.5))
        
                        projection_distance = distance 
                        # projection_distance = 0.01
                        
                        #   change to allow multiple angles
                        #   calculate angle instead
                        angle = 45
                    else
                        collision = false
                        projection_distance = 0
                        angle = 0
                    end
                # end


                
            else
                #aabb
                collision, projection_distance, angle = aabb_collision(object1_x, object1_y, object1_width, object1_height, object2_x, object2_y, object2_width, object2_height)
            end


        when "down_left" && !above && to_left

        when "down_right" && !above && !to_left

        else

        end

        unless intersect_x == nil
        @intersect_x = intersect_x
        @intersect_y = intersect_y
        end


        return collision, projection_distance, angle

    end

    def draw

        $font.draw(@intersect_x, 20, 130, 10, scale_x = 2, scale_y = 2, color = 0xff_ffffff)
        $font.draw(@intersect_y, 20, 160, 10, scale_x = 2, scale_y = 2, color = 0xff_ffffff)
        $font.draw(@aboveright, 1800, 600, 10, scale_x = 2, scale_y = 2, color = 0xff_ffffff)
  
        $font.draw(@object1_x, 1400, 0, 10, scale_x = 2, scale_y = 2, color = 0xff_ffffff)
        $font.draw(@object2_x, 1400, 30, 10, scale_x = 2, scale_y = 2, color = 0xff_ffffff)
        $font.draw(@object1_bottom_y, 1800, 0, 10, scale_x = 2, scale_y = 2, color = 0xff_ffffff)
        $font.draw(@object2_bottom_y, 1800, 30, 10, scale_x = 2, scale_y = 2, color = 0xff_ffffff)

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