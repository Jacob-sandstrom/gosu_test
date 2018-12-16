



class Camera 
    def initialize

        $cam_x = 0
        $cam_y = 0


    end


    def update
        $cam_x = $player_x - 960
        $cam_y = $player_y - 540

        if $cam_x <= 0
            $cam_x = 0
        elsif $cam_x >= $width_in_blocks * $block_size - 1920
            $cam_x = $width_in_blocks * $block_size - 1920
        end
        if $cam_y <= 0
            $cam_y = 0
        elsif $cam_y >= $height_in_blocks * $block_size - 1080
            $cam_y = $height_in_blocks * $block_size - 1080
        end
    end

    def draw

        # $font.draw($cam_x + $mouse_x, 10, 100, 0, scale_x = 2, scale_y = 2, color = 0xff_ffffff)
        # $font.draw($cam_y + $mouse_y, 10, 140, 0, scale_x = 2, scale_y = 2, color = 0xff_ffffff)
    end

end