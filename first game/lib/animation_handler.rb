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
            # @current_animation = @attack_down_first
            @current_animation = @idle_down
        rescue
            @current_animation = Animation_player.new(nil)
            print "animation no exist"
        end
    end

    def switch_animation(animation, dir)
        animation_changed = false
        data = @current_animation.meta_data
        current_frame = data["frames"][@current_animation.current_frame]
        if animation == "attack" && data["type"] == "attack"

            if current_frame["queue_combo"] == true
                @current_animation.queue_attack = true
            end

            if current_frame["execute_combo"] == true && @current_animation.queue_attack
                case @current_animation
                when @attack_down_first
                    @current_animation = @attack_down_second
                end
                animation_changed = true
            end

        else
            if current_frame["interruptible"] == true
                @current_animation = @attack_down_first
                animation_changed = true
            end

        end
        if animation_changed
            @current_animation.reset
        end
    end

    def animation_done
        if @current_animation.done == true
            @current_animation = @idle_down
        end
    end

    def update
        @current_animation.update
        animation_done
    end
    
    def draw(x, y)
        @current_animation.draw(x, y)
    end

end
