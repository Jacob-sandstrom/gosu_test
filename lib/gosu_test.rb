require 'gosu'

class Gosu_test < Gosu::Window
    def initialize
        width = 800
        height = 600
        super width, height
        self.caption = "Gosu test"

        @background_image = Gosu::Image.new("Lennart2.png", :tilable => true)



    end

    def draw

        @background_image.draw(0,0,0)

    end

    
end

Gosu_test.new.show
