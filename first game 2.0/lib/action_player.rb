require 'yaml'

class Action_player
    attr_accessor :current_frame, :meta_data, :done
    def initialize(meta_data)
        begin
            @done = false
            @meta_data = meta_data
            
            @number_of_frames = @meta_data["frames"].length
            @current_frame = 0
            @frames_delayed = 0
            @x_offset, @y_offset = @meta_data["offset"]
        rescue
            puts "Error: Unable to initialize #{meta_data["name"]}"
        end
    end
    
    def reset
        @current_frame = 0
        @frames_delayed = 0
        @done = false
    end

    def update
        begin
            if @frames_delayed < @meta_data["frames"][@current_frame]["display_time"]
                @frames_delayed += 1
            else
                @current_frame += 1
                @frames_delayed = 0
            end
            if @current_frame >= @number_of_frames 
                if @meta_data["loop"] == true
                    reset
                else
                    @done = true
                end
            end
        rescue
        end
    end

end
