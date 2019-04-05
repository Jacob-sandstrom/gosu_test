require 'yaml'

class Animation_player
    attr_accessor :current_frame, :meta_data, :done, :queue_attack
    def initialize(meta_data, done=false, queue_attack=false)
        begin
            
            @queue_attack = queue_attack
            @done = done
            @meta_data = meta_data

            begin  
                spritesheet = meta_data["spritesheet"]
                img_width = @meta_data["size"][0]
                img_height = @meta_data["size"][1]
                @animation_frames = Gosu::Image.load_tiles(spritesheet, img_width, img_height, tileable: true)
            rescue 
                puts "Error: Unable to load animation #{@meta_data["name"]}"
            end
            
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
        @queue_attack = false
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
    
    def draw(window, x, y)
        begin               
            @animation_frames[@current_frame].draw(x, y, 10)      
        rescue
        end
    end

end
