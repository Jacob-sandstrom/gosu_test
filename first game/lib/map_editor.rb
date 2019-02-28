require 'gosu'
require_relative 'collision_detection.rb'


class Map_editor
    def initialize
        @collision_detection = Collision_detection.new 

        @toggle_variable = 0
        @floor_editing_enabled = false
        @object_editing_enabled = false


        # @block_img = Gosu::Image.new("../img/Block.png", tileable: true)

        @floor_gold = Gosu::Image.new("../img/green.png", tileable: true)
        @floor_blue = Gosu::Image.new("../img/floor_blue.png", tileable: true)
        @floor_green = Gosu::Image.new("../img/grass.png", tileable: true)
        @floor_purple = Gosu::Image.new("../img/grass_top.png", tileable: true)

        @top_left_triangle = Gosu::Image.new("../img/top_left_triangle.png", tileable: true)
        @top_right_triangle = Gosu::Image.new("../img/top_right_triangle.png", tileable: true)
        @bottom_left_triangle = Gosu::Image.new("../img/bottom_left_triangle.png", tileable: true)
        @bottom_right_triangle = Gosu::Image.new("../img/bottom_right_triangle.png", tileable: true)



        @tree = Gosu::Image.new("../img/dead_tree.png", tileable: true)
        @light = Gosu::Image.new("../img/lighttest.png", tileable: true)


        $block_size = 32

        $current_tile_id = "0"
        $current_object_id = "0"


        $tiles = [@floor_gold, @floor_blue, @floor_green, @floor_purple]
        $tile_id = ["0", "1", "2", "3"]

        $objects = [@tree, @top_left_triangle, @top_right_triangle, @bottom_left_triangle, @bottom_right_triangle]
        $object_id = ["0", "1", "2", "3", "4"]

        $floortiles =  File.read('maps/arena_floor.txt')
        $object_map = File.read('maps/arena_objects.txt')
        # $floortiles =  File.read('maps/floortiles.txt')
        # $object_map = File.read('maps/object_map.txt')

    end

    def update_existing_floor
        # File.open("path/to/file", "w") do |file| 
        #     file.write("values")
        # end
        
        File.open("maps/arena_floor.txt", 'w') { |file| file.write($floortiles)}
        # File.open("maps/floortiles.txt", 'w') { |file| file.write($floortiles)}

    end

    def draw_on_floor
        if Gosu.button_down? Gosu::MS_LEFT 
            i = 0
            while i < $height_in_blocks
                if i*$block_size >= $cam_y - 64 && i*$block_size <= $cam_y + 1080 + 64
                    j = 0
                    while j < $width_in_blocks
                        if j*$block_size >= $cam_x - 64 && j*$block_size <= $cam_x + 1920 + 64
                            collision, projection, angle = @collision_detection.aabb_collision($mouse_x + $cam_x, $mouse_y + $cam_y, 0, 0, j*$block_size, i*$block_size, $block_size, $block_size)
                            if collision
                                begin
                                    $floortiles[j + i*$width_in_blocks] = $current_tile_id
                                rescue
                                    length = $floortiles.length
                                    iterations = 0
                                    index_of_change = j + i*$width_in_blocks
                                    while length + iterations < index_of_change
                                        $floortiles += "."
                                        iterations += 1
                                    end
                                end
                                update_existing_floor
                            end
                        end
                        j += 1
                    end
                end
                i += 1
            end
        end

        if Gosu.button_down? Gosu::MS_RIGHT
            i = 0
            while i < $height_in_blocks
                if i*$block_size >= $cam_y - 64 && i*$block_size <= $cam_y + 1080 + 64
                    j = 0
                    while j < $width_in_blocks
                        if j*$block_size >= $cam_x - 64 && j*$block_size <= $cam_x + 1920 + 64
                            collision, projection, angle = @collision_detection.aabb_collision($mouse_x + $cam_x, $mouse_y + $cam_y, 0, 0, j*$block_size, i*$block_size, $block_size, $block_size)
                            if collision
                                begin
                                    $floortiles[j + i*$width_in_blocks] = "."
                                rescue
                                    length = $floortiles.length
                                    iterations = 0
                                    index_of_change = j + i*$width_in_blocks
                                    while length + iterations < index_of_change
                                        $floortiles += "."
                                        iterations += 1
                                    end
                                end
                                update_existing_floor
                            end
                        end
                        j += 1
                    end
                end
                i += 1
            end
        end
    end


    def update_existing_objects

        File.open("maps/arena_objects.txt", 'w') { |file| file.write($object_map)}
        # File.open("maps/object_map.txt", 'w') { |file| file.write($object_map)}

    end

    def draw_on_object_map
        if Gosu.button_down? Gosu::MS_LEFT 
            i = 0
            while i < $height_in_blocks
                if i*$block_size >= $cam_y - 64 && i*$block_size <= $cam_y + 1080 + 64
                    j = 0
                    while j < $width_in_blocks
                        if j*$block_size >= $cam_x - 64 && j*$block_size <= $cam_x + 1920 + 64
                            collision, projection, angle = @collision_detection.aabb_collision($mouse_x + $cam_x, $mouse_y + $cam_y, 0, 0, j*$block_size, i*$block_size, $block_size, $block_size)
                            if collision
                                begin
                                    $object_map[j + i*$width_in_blocks] = $current_object_id
                                rescue
                                    length = $object_map.length
                                    iterations = -1
                                    index_of_change = j + i*$width_in_blocks
                                    while length + iterations < index_of_change
                                        $object_map += "."
                                        iterations += 1
                                    end
                                end
                                update_existing_objects
                            end
                        end
                        j += 1
                    end
                end
                i += 1
            end
        end

        if Gosu.button_down? Gosu::MS_RIGHT
            i = 0
            while i < $height_in_blocks
                if i*$block_size >= $cam_y - 64 && i*$block_size <= $cam_y + 1080 + 64
                    j = 0
                    while j < $width_in_blocks
                        if j*$block_size >= $cam_x - 64 && j*$block_size <= $cam_x + 1920 + 64
                            collision, projection, angle = @collision_detection.aabb_collision($mouse_x + $cam_x, $mouse_y + $cam_y, 0, 0, j*$block_size, i*$block_size, $block_size, $block_size)
                            if collision
                                begin
                                    $object_map[j + i*$width_in_blocks] = "."
                                rescue
                                    length = $object_map.length
                                    iterations = -1
                                    index_of_change = j + i*$width_in_blocks
                                    while length + iterations < index_of_change
                                        $object_map += "."
                                        iterations += 1
                                    end
                                end
                                update_existing_objects
                            end
                        end
                        j += 1
                    end
                end
                i += 1
            end
        end
    end

    def toggle_editing

        if (Gosu.button_down? Gosu::KB_T) && !@toggle_pressed
            @toggle_variable += 1
            @toggle_pressed = true
        elsif !(Gosu.button_down? Gosu::KB_T)
            @toggle_pressed = false
        end

        if @toggle_variable == 0
            @floor_editing_enabled = false
            @object_editing_enabled = false
        elsif @toggle_variable == 1
            @floor_editing_enabled = true
            @object_editing_enabled = false
        elsif @toggle_variable == 2
            @floor_editing_enabled = false
            @object_editing_enabled = true
        end
        
        @toggle_variable %= 3
        
    end
    

    def update
        toggle_editing

        #   Draw on map with mouse
        if @floor_editing_enabled
            draw_on_floor
        end
        if @object_editing_enabled
            draw_on_object_map
        end


        if (Gosu.button_down? Gosu::KB_0)
            $current_tile_id = "0"
            $current_object_id = "0"
        elsif (Gosu.button_down? Gosu::KB_1)
            $current_tile_id = "1"
            $current_object_id = "1"
        elsif (Gosu.button_down? Gosu::KB_2)
            $current_tile_id = "2"
            $current_object_id = "2"
        elsif (Gosu.button_down? Gosu::KB_3)
            $current_tile_id = "3"
            $current_object_id = "3"
        elsif (Gosu.button_down? Gosu::KB_4)
            $current_tile_id = "4"
            $current_object_id = "4"
        elsif (Gosu.button_down? Gosu::KB_5)
            $current_tile_id = "5"
            $current_object_id = "5"
        elsif (Gosu.button_down? Gosu::KB_6)
            $current_tile_id = "6"
            $current_object_id = "6"
        elsif (Gosu.button_down? Gosu::KB_7)
            $current_tile_id = "7"
            $current_object_id = "7"
        end

    end

    def draw
        

        i = 0
        while i < $height_in_blocks
            if i*$block_size >= $cam_y - 64 && i*$block_size <= $cam_y + 1080 + 64
                j = 0
                while j < $width_in_blocks
                    if j*$block_size >= $cam_x - 64 && j*$block_size <= $cam_x + 1920 + 64

                        tile_id = $tile_id.index($floortiles[j + i*$width_in_blocks])

                        unless $floortiles[j + i*$width_in_blocks] == "." 
                            $tiles[tile_id.to_i].draw(j*$block_size - $cam_x, i*$block_size - $cam_y, 0)
                        end

                        object_id = $object_id.index($object_map[j + i*$width_in_blocks])
                        
                        if i*$block_size  > $player_y
                            unless $object_map[j + i*$width_in_blocks] == "." 
                                if object_id.to_i == "0"
                                    $objects[object_id.to_i].draw(j*$block_size - 32 - $cam_x, i*$block_size - 64 - $cam_y, 11)
                                else  
                                    $objects[object_id.to_i].draw(j*$block_size - $cam_x, i*$block_size - $cam_y, 11)
                                end
                                # @light.draw(j*$block_size - 32 - $cam_x, i*$block_size - 64 - $cam_y, 1, 1, 1, color = 0x7f_ffffff)
                            end
                        else
                            unless $object_map[j + i*$width_in_blocks] == "." 
                                if object_id.to_i == "0"
                                    $objects[object_id.to_i].draw(j*$block_size - 32 - $cam_x, i*$block_size - 64 - $cam_y, 1)
                                else  
                                    $objects[object_id.to_i].draw(j*$block_size - $cam_x, i*$block_size - $cam_y, 1)
                                end
                                # @light.draw(j*$block_size - 32 - $cam_x, i*$block_size - 64 - $cam_y, 1, 1, 1, color = 0x7f_ffffff)
                            end
                        end
                    end

                    j += 1
                end
            end
            i += 1
        end  
        
        $font.draw("floor editing enabled:", 10, 10, 10, scale_x = 2, scale_y = 2, color = 0xff_ffffff)
        $font.draw(@floor_editing_enabled, 400, 10, 10, scale_x = 2, scale_y = 2, color = 0xff_ffffff)
        $font.draw("object editing enabled:", 10, 50, 10, scale_x = 2, scale_y = 2, color = 0xff_ffffff)
        $font.draw(@object_editing_enabled, 400, 50, 10, scale_x = 2, scale_y = 2, color = 0xff_ffffff)

        
    end

end