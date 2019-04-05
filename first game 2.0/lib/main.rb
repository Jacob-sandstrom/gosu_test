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

    #   displays cursor on screen
    def needs_cursor?
        true
    end

    #   call all update functions from other clases
    def update
        @game_objects.each do |object|
            object.update
        end

    end

    #   call all draw functions from other clases
    def draw
        @game_objects.each do |object|
            object.draw(Main)
        end
        #   temporary placement move to hitbox_shower class
        draw_rect(0,0,100,100, Gosu::Color.argb(0xa5_c0ffc0), 100)      #   color for hittable hitbox
        draw_rect(100,0,100,100, Gosu::Color.argb(0xa5_ffc0c0), 100)    #   color for attack hitbox
    end

    #   close game if esc is pressed
    def button_down(id)
        if id == Gosu::KB_ESCAPE
          close
        else
          super
        end
    end

end


Main.new.show