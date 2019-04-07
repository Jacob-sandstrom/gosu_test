require 'yaml'
require_relative 'action_player.rb'
require_relative 'animation_player.rb'

class Action_handler
    attr_accessor :file, :current_action, :allow_move, :x_move, :y_move

    def initialize(file)
        player_actions = YAML.load(File.read(file))

        @actions = {}
        @animations = {}

        player_actions.keys.each do |key|
            # instance_variable_set("@#{key}", Action_player.new(player_actions[key]))
            # instance_variable_set("@#{key}_animation", Animation_player.new(player_actions[key]))
            @actions[key] = Action_player.new(player_actions[key])
            @animations[key] = Animation_player.new(player_actions[key])

        end
        begin
            @current_action = @actions[@actions.keys[0]]
            @current_animation = @animations[@animations.keys[0]]
        rescue
            @current_action = Action_player.new(nil)
            @current_animation = Animation_player.new(nil)
            print "action no exist"
        end

        @queued_action = nil
        @attack_queued = false
        @allow_move = true
        @x_move = 0
        @y_move = 0
    end

    def switch_action(action)
        action_changed = false
        data = @current_action.meta_data
        current_frame = data["frames"][@current_action.current_frame]
        if current_frame["queue_combo"] == true
            @attack_queued = true
            @queued_action = @current_action.meta_data["next"]
        end
        if action == "attack" && data["type"] == "attack"

        else
            
        end 

        if current_frame["interruptible"] == true

            @current_action = @actions[action]
            @current_animation = @animations[action]

            action_changed = true
        end
        
        if action_changed
            @current_action.reset
            @current_animation.reset
        end
    end

    def switch_to_queued
        if @attack_queued
            action_changed = false
            data = @current_action.meta_data
            current_frame = data["frames"][@current_action.current_frame]
            if current_frame["execute_combo"] == true && @attack_queued
                @current_action = @actions[@queued_action]
                @current_animation = @animations[@queued_action]
                @attack_queued = false
                action_changed = true
            end
            if action_changed
                @current_action.reset
                @current_animation.reset
            end
        end
    end

    def action_done
        if @current_action.done == true
            @current_action = @actions[@actions.keys[0]]
            @current_animation = @animations[@animations.keys[0]]
        end
    end

    def update(x, y)
        switch_to_queued
        @current_action.update
        @current_animation.update
        action_done
        @allow_move = @current_action.meta_data["allow_movement"]
        @x_move = @current_action.meta_data["frames"][@current_action.current_frame]["x_movement"]
        @y_move = @current_action.meta_data["frames"][@current_action.current_frame]["y_movement"]
    end
    
    def draw(window, x, y)
        @current_animation.draw(window, x, y)
    end

end
