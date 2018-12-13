require 'gosu'


class Main < Gosu::Window
    def initialize
        width = 1920
        height = 1080
        super width, height, fullscreen:true
        self.caption = "Game"


    end

    def needs_cursor?
        true
    end


    def update

    end

    def draw

    end


end


Main.new.show