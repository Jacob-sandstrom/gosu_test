require 'yaml'
require_relative 'animation_player.rb'

class Animation_handler
    attr_accessor :current_animation

    def initialize
        player_animations = YAML.load(File.read("../animations/player animations/player_animations.yaml"))

        player_animations.keys.each do |key|
            instance_variable_set("@#{key}", Animation_player.new(player_animations[key]))
        end
        begin
            @current_animation = @attack_down_first
            @current_animation.play
        rescue
            @current_animation = Animation_player.new(nil)
            print "animation no exist"
        end
    end

    def update
        @current_animation.update
    end
    
    def draw(x, y)
        @current_animation.draw(x, y)
    end

end
