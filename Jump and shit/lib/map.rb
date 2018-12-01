
class Map
    def initialize
        @block_img = Gosu::Image.new("../img/Block.png", tileable: true)
        $block_size = 32


        $map_x = 0
        $map_y = 0

        

        @map_0_0_string =  File.read('maps/map_0_0.txt')
        @map_0_1_string =  File.read('maps/map_0_1.txt')
        @map_0_2_string =  File.read('maps/map_0_2.txt')
        @map_1_0_string =  File.read('maps/map_1_0.txt')
        @map_1_1_string =  File.read('maps/map_1_1.txt')
        @map_1_2_string =  File.read('maps/map_1_2.txt')
        @map_2_0_string =  File.read('maps/map_2_0.txt')
        @map_2_1_string =  File.read('maps/map_2_1.txt')
        @map_2_2_string =  File.read('maps/map_2_2.txt')

   
        

        
        $maps = [[@map_0_0_string, @map_0_1_string, @map_0_2_string], [@map_1_0_string, @map_1_1_string, @map_1_2_string], [@map_2_0_string, @map_2_1_string, @map_2_2_string]]
        
        $current_map = $maps[$map_x][$map_y]
    end


    def draw

        File.open('maps/map_0_0.txt', 'w') { |file| file.write(@map_0_0_string)}
        File.open('maps/map_0_1.txt', 'w') { |file| file.write(@map_0_1_string)}
        File.open('maps/map_0_2.txt', 'w') { |file| file.write(@map_0_2_string)}
        File.open('maps/map_1_0.txt', 'w') { |file| file.write(@map_1_0_string)}
        File.open('maps/map_1_1.txt', 'w') { |file| file.write(@map_1_1_string)}
        File.open('maps/map_1_2.txt', 'w') { |file| file.write(@map_1_2_string)}
        File.open('maps/map_2_0.txt', 'w') { |file| file.write(@map_2_0_string)}
        File.open('maps/map_2_1.txt', 'w') { |file| file.write(@map_2_1_string)}
        File.open('maps/map_2_2.txt', 'w') { |file| file.write(@map_2_2_string)}
        
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