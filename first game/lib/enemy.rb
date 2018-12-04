
class Enemy
    def initialize
        @image = Gosu::Image.new("../img/enemy.png")

        $enemy_x, $enemy_y = $enemy_spawn

    end




    def draw
        @image.draw($enemy_x, $enemy_y, 8)
    end

end