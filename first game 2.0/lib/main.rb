require 'gosu'
require_relative 'player.rb'
require_relative 'enemy.rb'



class Main < Gosu::Window
    def initialize
        width = 1920
        height = 1080
        super width, height, fullscreen:true
        self.caption = "Game"

        @game_objects = [
        Player.new("../actions/player actions/player_action_data.yaml"),
        Enemy.new("../actions/enemy actions/enemy_action_data.yaml")
        ]

        @player = Player.new("../actions/player actions/player_action_data.yaml")
        @enemies = [Enemy.new("../actions/enemy actions/enemy_action_data.yaml")]
    end

    #   displays cursor on screen
    def needs_cursor?
        true
    end

    #   call all update functions from other clases
    def update
        @player.update

        @enemies.each do |enemy|
            enemy.update(@player)
        end

    end

    #   call all draw functions from other clases
    def draw
        # @game_objects.each do |object|
        #     object.draw(self)
        # end

        @player.draw(self)

        @enemies.each do |enemy|
            enemy.draw(self)
        end
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