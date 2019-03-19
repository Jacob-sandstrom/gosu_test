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

        @attack_queued = false
    end

    def switch_animation(animation, dir)
        animation_changed = false
        data = @current_animation.meta_data
        current_frame = data["frames"][@current_animation.current_frame]
        if current_frame["queue_combo"] == true
            @current_animation.queue_attack = true
            @attack_queued = true
        end
        if animation == "attack" && data["type"] == "attack"

        else
            
        end 

        if current_frame["interruptible"] == true
            @current_animation = @attack_down_first
            animation_changed = true
        end
        
        if animation_changed
            @current_animation.reset
        end
    end

    def switch_to_queued
        if @attack_queued
            animation_changed = false
            data = @current_animation.meta_data
            current_frame = data["frames"][@current_animation.current_frame]
            if current_frame["execute_combo"] == true && @current_animation.queue_attack
                case @current_animation
                when @attack_down_first
                    @current_animation = @attack_down_second
                end
                animation_changed = true
            end
            if animation_changed
                @current_animation.reset
            end
        end
    end

    def animation_done
        if @current_animation.done == true
            @current_animation = @idle_down
        end
    end

    def update
        switch_to_queued
        @current_animation.update
        animation_done
    end
    
    def draw(x, y)
        @current_animation.draw(x, y)
    end

end
