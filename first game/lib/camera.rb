



class Camera 
    def initialize

        $cam_x = 0
        $cam_y = 0


    end


    def update
        $cam_x = $player_x - 960
        $cam_y = $player_y - 540
    end

    def draw

        $font.draw($cam_x, 10, 100, 0, scale_x = 2, scale_y = 2, color = 0xff_ffffff)
        $font.draw($cam_y, 10, 500, 0, scale_x = 2, scale_y = 2, color = 0xff_ffffff)

    end

end