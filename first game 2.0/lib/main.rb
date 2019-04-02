require 'gosu'
require_relative 'player.rb'



class Main < Gosu::Window
    def initialize
        width = 1920
        height = 1080
        super width, height, fullscreen:true
        self.caption = "Game"

        @game_objects = [Player.new("../actions/player actions/player_action_data.yaml")]

    end

    def needs_cursor?
        true
    end

    def update
        @game_objects.each do |object|
            object.update
        end

    end

    def draw
        @game_objects.each do |object|
            object.draw
        end
    end

    def button_down(id)
        if id == Gosu::KB_ESCAPE
          close
        else
          super
        end
    end

end


Main.new.show