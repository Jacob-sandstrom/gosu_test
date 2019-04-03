require_relative 'game_object.rb'


class Player < Game_object
    # attr_reader 
    
    def initialize(file)
        super(file)


    end

    def check_inputs
        if (Gosu.button_down? Gosu::KB_SPACE or Gosu::button_down? Gosu::GP_BUTTON_1)
            @action_handler.switch_action(nil, nil)
        end
        if (Gosu.button_down? Gosu::KB_W or Gosu::button_down? Gosu::GP_UP)
            @y_vel += -1
        end
        if (Gosu.button_down? Gosu::KB_A or Gosu::button_down? Gosu::GP_LEFT)
            @x_vel += -1
            #   do stuff
        end
        if (Gosu.button_down? Gosu::KB_S or Gosu::button_down? Gosu::GP_DOWN)
            @y_vel += 1
            #   do stuff
        end
        if (Gosu.button_down? Gosu::KB_D or Gosu::button_down? Gosu::GP_RIGHT)
            @x_vel += 1
            #   do stuff
        end

    end

    def update
        super
        check_inputs

    end

    def draw
        super

    end


end