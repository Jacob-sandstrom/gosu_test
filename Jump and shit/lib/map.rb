
class Map
    def initialize
        @block_img = Gosu::Image.new("../img/Block.png", tileable: true)
        $block_size = 32


        $map_x = 0
        $map_y = 0

        

        @map_0_0 =  File.read('maps/map_0_0.txt')
        @map_0_1 =  File.read('maps/map_0_1.txt')
        @map_0_2 =  File.read('maps/map_0_2.txt')
        @map_1_0 =  File.read('maps/map_1_0.txt')
        @map_1_1 =  File.read('maps/map_1_1.txt')
        @map_1_2 =  File.read('maps/map_1_2.txt')
        @map_2_0 =  File.read('maps/map_2_0.txt')
        @map_2_1 =  File.read('maps/map_2_1.txt')
        @map_2_2 =  File.read('maps/map_2_2.txt')
        @map_3_0 =  File.read('maps/map_3_0.txt')
        @map_3_1 =  File.read('maps/map_3_1.txt')
        @map_3_2 =  File.read('maps/map_3_2.txt')

   
        

        
        $maps = [[@map_0_0, @map_0_1, @map_0_2], [@map_1_0, @map_1_1, @map_1_2], [@map_2_0, @map_2_1, @map_2_2], [@map_3_0, @map_3_1, @map_3_2]]
        
        $current_map = $maps[$map_x][$map_y]
    end

    def update_existing_map(map_x, map_y)

        File.open("maps/map_#{map_x}_#{map_y}.txt", 'w') { |file| file.write($maps[map_x][map_y])}

    end


    def draw
        
        $current_map = $maps[$map_x][$map_y]

            i = 0
            while i < $height_in_blocks
                j = 0
                while j < $width_in_blocks
                    if $current_map[j + i*$width_in_blocks] == "#"
                    @block_img.draw(j*$block_size, i*$block_size, 0)
                    end
                    j += 1
                end
                i += 1
            end
            
            
    end



end