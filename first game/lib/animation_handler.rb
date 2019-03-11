

class Animation_handler
    attr_accessor :current_animation

    def initialize

    end

    def update

    end

    def draw

    end

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