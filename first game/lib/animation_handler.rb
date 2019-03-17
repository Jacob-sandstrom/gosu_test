require 'yaml'
require_relative 'animation_player.rb'

class Animation_handler
    attr_accessor :current_animation

    def initialize
        player_animations = YAML.load(File.read("../animations/player animations/player_animations.yaml"))

        player_animations.keys.each do |key|
            instance_variable_set("@#{key}", Animation_player.new(0, 0, 0, player_animations[key]))
        end

    end

    def update
        @attack_down_first.update
        @attack_down_second.update
    end
    
    def draw(x, y)
        @attack_down_first.draw(x, y)
        @attack_down_second.draw(x, y)
    end

end
