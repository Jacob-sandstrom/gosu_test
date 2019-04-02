

class Input_handler

    def initialize

    end

    def check_inputs

        if (Gosu.button_down? Gosu::KB_SPACE or Gosu::button_down? Gosu::GP_BUTTON_1)
            
        end
        if (Gosu.button_down? Gosu::KB_W or Gosu::button_down? Gosu::GP_UP)
            #   do stuff
        end
        if (Gosu.button_down? Gosu::KB_A or Gosu::button_down? Gosu::GP_LEFT)
            #   do stuff
        end
        if (Gosu.button_down? Gosu::KB_S or Gosu::button_down? Gosu::GP_DOWN)
            #   do stuff
        end
        if (Gosu.button_down? Gosu::KB_D or Gosu::button_down? Gosu::GP_RIGHT)
            #   do stuff
        end

    end
    
end