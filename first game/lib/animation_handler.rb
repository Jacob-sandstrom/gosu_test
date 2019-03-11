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
        @attack_down.update
        @attack_up.update
    end
    
    def draw
        @attack_down.draw
        @attack_up.draw

    end

end

if __FILE__==$0

    Animation_handler.new
end
=begin

animations =
[
    {
        "name" => attack_down, "frames" => 
        [
            {"name" => frame_0, "image" => Gosu::image, "x_offset" => 0, "y_offset" => 0, "x_movement" => 0, "y_movement" => 0, "interuptable" => false, "hitboxes" => [{"type" => "hittable", "bounds" => [player_x, y, width, height], "damage" => 0, "knockback_x" => 0, "knockback_y" => 0}],[{"type" => "attack", "bounds" => [player_x + 30, y + 100, 100, 30], "damage" => 2, "knockback_x" => 0, "knockback_y" => 30}]]}
            {"name" => frame_1, "image" => Gosu::image, "x_movement" => 0, "y_movement" => 0, "interuptable" => false, "hitboxes" => [{"type" => "hittable", "bounds" => [player_x, y, width, height], "damage" => 0, "knockback_x" => 0, "knockback_y" => 0},[{"type" => "attack", "bounds" => [player_x + 30, y + 100, 100, 30], "damage" => 2, "knockback_x" => 0, "knockback_y" => 30}]]}
            {"name" => frame_2, "image" => Gosu::image, "x_movement" => 0, "y_movement" => 0, "interuptable" => false, "hitboxes" => [{"type" => "hittable", "bounds" => [player_x, y, width, height], "damage" => 0, "knockback_x" => 0, "knockback_y" => 0},[{"type" => "attack", "bounds" => [player_x + 30, y + 100, 100, 30], "damage" => 2, "knockback_x" => 0, "knockback_y" => 30}]]}
            {"name" => frame_3, "image" => Gosu::image, "x_movement" => 0, "y_movement" => 0, "interuptable" => false, "hitboxes" => [{"type" => "hittable", "bounds" => [player_x, y, width, height], "damage" => 0, "knockback_x" => 0, "knockback_y" => 0},[{"type" => "attack", "bounds" => [player_x + 30, y + 100, 100, 30], "damage" => 2, "knockback_x" => 0, "knockback_y" => 30}]]}
        ]
    }
    {
        "name" => attack_up, "frames" => 
        [
            {"name" => frame_0, "image" => Gosu::image, "x_movement" => 0, "y_movement" => 0, "interuptable" => false, "hitboxes" => [{"type" => "hittable", "bounds" => [player_x, y, width, height], "damage" => 0, "knockback_x" => 0, "knockback_y" => 0},[{"type" => "attack", "bounds" => [player_x + 30, y + 100, 100, 30], "damage" => 2, "knockback_x" => 0, "knockback_y" => 30}]]}
            {"name" => frame_1, "image" => Gosu::image, "x_movement" => 0, "y_movement" => 0, "interuptable" => false, "hitboxes" => [{"type" => "hittable", "bounds" => [player_x, y, width, height], "damage" => 0, "knockback_x" => 0, "knockback_y" => 0},[{"type" => "attack", "bounds" => [player_x + 30, y + 100, 100, 30], "damage" => 2, "knockback_x" => 0, "knockback_y" => 30}]]}
            {"name" => frame_2, "image" => Gosu::image, "x_movement" => 0, "y_movement" => 0, "interuptable" => false, "hitboxes" => [{"type" => "hittable", "bounds" => [player_x, y, width, height], "damage" => 0, "knockback_x" => 0, "knockback_y" => 0},[{"type" => "attack", "bounds" => [player_x + 30, y + 100, 100, 30], "damage" => 2, "knockback_x" => 0, "knockback_y" => 30}]]}
            {"name" => frame_3, "image" => Gosu::image, "x_movement" => 0, "y_movement" => 0, "interuptable" => false, "hitboxes" => [{"type" => "hittable", "bounds" => [player_x, y, width, height], "damage" => 0, "knockback_x" => 0, "knockback_y" => 0},[{"type" => "attack", "bounds" => [player_x + 30, y + 100, 100, 30], "damage" => 2, "knockback_x" => 0, "knockback_y" => 30}]]}
        ]
    }
]


=end