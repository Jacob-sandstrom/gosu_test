require 'gosu'
require_relative 'collision_detection.rb'


class Map_editor
    def initialize
        @collision_detection = Collision_detection.new 

        @toggle_variable = 0
        @floor_editing_enabled = false
        @object_editing_enabled = false


        # @block_img = Gosu::Image.new("../img/Block.png", tileable: true)

        @floor_gold = Gosu::Image.new("../img/floor_gold.png", tileable: true)
        @floor_blue = Gosu::Image.new("../img/floor_blue.png", tileable: true)
        @floor_green = Gosu::Image.new("../img/floor_green.png", tileable: true)
        @floor_purple = Gosu::Image.new("../img/floor_purple.png", tileable: true)



        @tree = Gosu::Image.new("../img/dead_tree.png", tileable: true)


        $block_size = 32

        $current_tile_id = "0"

        $tiles = [@floor_gold, @floor_blue, @floor_green, @floor_purple]
        $tile_id = ["0", "1", "2", "3"]


        $floortiles =  File.read('maps/floortiles.txt')
        $object_map = File.read('maps/object_map.txt')

    end

    def update_existing_floor

        File.open("maps/floortiles.txt", 'w') { |file| file.write($floortiles)}

    end

    def draw_on_floor
        if Gosu.button_down? Gosu::MS_LEFT 
            i = 0
            while i < $height_in_blocks
                if i*$block_size >= $cam_y - 64 && i*$block_size <= $cam_y + 1080 + 64
                    j = 0
                    while j < $width_in_blocks
                        if j*$block_size >= $cam_x - 64 && j*$block_size <= $cam_x + 1920 + 64
                            collision, axis, projection = @collision_detection.collide?($mouse_x + $cam_x, $mouse_y + $cam_y, 0, 0, j*$block_size, i*$block_size, $block_size, $block_size)
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
                            collision, axis, projection = @collision_detection.collide?($mouse_x + $cam_x, $mouse_y + $cam_y, 0, 0, j*$block_size, i*$block_size, $block_size, $block_size)
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

        File.open("maps/object_map.txt", 'w') { |file| file.write($object_map)}

    end

    def draw_on_object_map
        if Gosu.button_down? Gosu::MS_LEFT 
            i = 0
            while i < $height_in_blocks
                if i*$block_size >= $cam_y - 64 && i*$block_size <= $cam_y + 1080 + 64
                    j = 0
                    while j < $width_in_blocks
                        if j*$block_size >= $cam_x - 64 && j*$block_size <= $cam_x + 1920 + 64
                            collision, axis, projection = @collision_detection.collide?($mouse_x + $cam_x, $mouse_y + $cam_y, 0, 0, j*$block_size, i*$block_size, $block_size, $block_size)
                            if collision
                                begin
                                    $object_map[j + i*$width_in_blocks] = "#"
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
                            collision, axis, projection = @collision_detection.collide?($mouse_x + $cam_x, $mouse_y + $cam_y, 0, 0, j*$block_size, i*$block_size, $block_size, $block_size)
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
        elsif (Gosu.button_down? Gosu::KB_1)
            $current_tile_id = "1"
        elsif (Gosu.button_down? Gosu::KB_2)
            $current_tile_id = "2"
        elsif (Gosu.button_down? Gosu::KB_3)
            $current_tile_id = "3"
        end

    end

    def draw
        

        i = 0
        while i < $height_in_blocks
            if i*$block_size >= $cam_y - 64 && i*$block_size <= $cam_y + 1080 + 64
                j = 0
                while j < $width_in_blocks
                    if j*$block_size >= $cam_x - 64 && j*$block_size <= $cam_x + 1920 + 64

                        id = $tile_id.index($floortiles[j + i*$width_in_blocks])

                        unless $floortiles[j + i*$width_in_blocks] == "." 
                            $tiles[id.to_i].draw(j*$block_size - $cam_x, i*$block_size - $cam_y, 0)
                        end
                        
                        unless $object_map[j + i*$width_in_blocks] == "." 
                            @tree.draw(j*$block_size - 32 - $cam_x, i*$block_size - 64 - $cam_y, 1)
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