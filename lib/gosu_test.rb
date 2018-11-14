require 'gosu'

class Game < Gosu::Window
    def initialize
        @width = 800
        @height = 600
        super @width, @height, false
    end
end

Game.new.show