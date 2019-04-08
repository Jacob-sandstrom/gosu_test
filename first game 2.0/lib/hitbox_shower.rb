

class Hitbox_shower

    def initialize(action_handler)
        @action_handler = action_handler

    end

    
    def update

    end

    def draw(window, pos_x, pos_y)
        # window.draw_rect(0,0,100,100, Gosu::Color.argb(0xa5_c0ffc0), 100)      #   color for hittable hitbox
        # window.draw_rect(100,0,100,100, Gosu::Color.argb(0xa5_ffc0c0), 100)    #   color for attack hitbox

        @action_handler.current_action.meta_data["frames"][@action_handler.current_action.current_frame]["hitboxes"].each do |hitbox|
            begin
                x, y, width, height = hitbox["bounds"]
                case hitbox["type"]
                when "hittable"
                    # window.draw_rect(x + pos_x, y + pos_y, width, height, Gosu::Color.argb(0xa5_c0ffc0), 100) 
                when "attack"
                    window.draw_rect(x + pos_x, y + pos_y, width, height, Gosu::Color.argb(0xa5_ffa0a0), 100) 

                end
            rescue
                p "Error: hitbox bounds does not exist for action: #{@action_handler.current_action.meta_data["name"]} in frame: #{@action_handler.current_action.current_frame}"
            end

        end
    end
    
end