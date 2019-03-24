require 'yaml'
require_relative 'action_player.rb'

class Action_handler
    attr_accessor :current_action, :x_move, :y_move

    def initialize
        player_actions = YAML.load(File.read("../actions/player actions/player_action_data.yaml"))

        player_actions.keys.each do |key|
            instance_variable_set("@#{key}", Action_player.new(player_actions[key]))
        end
        begin
            # @current_action = @attack_down_first
            @current_action = @idle_down
        rescue
            @current_action = Action_player.new(nil)
            print "action no exist"
        end

        @attack_queued = false
    end

    def switch_action(action, dir)
        action_changed = false
        data = @current_action.meta_data
        current_frame = data["frames"][@current_action.current_frame]
        if current_frame["queue_combo"] == true
            @current_action.queue_attack = true
            @attack_queued = true
        end
        if action == "attack" && data["type"] == "attack"

        else
            
        end 

        if current_frame["interruptible"] == true
            @current_action = @attack_down_first
            action_changed = true
        end
        
        if action_changed
            @current_action.reset
        end
    end

    def switch_to_queued
        if @attack_queued
            action_changed = false
            data = @current_action.meta_data
            current_frame = data["frames"][@current_action.current_frame]
            if current_frame["execute_combo"] == true && @current_action.queue_attack
                case @current_action
                when @attack_down_first
                    @current_action = @attack_down_second
                end
                action_changed = true
            end
            if action_changed
                @current_action.reset
            end
        end
    end

    def action_done
        if @current_action.done == true
            @current_action = @idle_down
        end
    end

    def update(x, y)
        switch_to_queued
        @current_action.update
        action_done
    end
    
    def draw(x, y)
        @current_action.draw(x, y)
    end

end
