require 'gosu'

class Gosu_test < Gosu::Window
    def initialize
        width = 800
        height = 600
        super width, height
        self.caption = "Gosu test"
    end

    
end

Gosu_test.new.show
