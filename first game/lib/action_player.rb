require 'yaml'

class Action_player
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
                action_frames = Gosu::Image.load_tiles(spritesheet, img_width, img_height, tileable: true)
                
                action_frames.each_with_index do |image, index|
                    if @meta_data["frames"][index] == nil
                        puts "error: @meta_data[frames][#{index}] does not exist"
                        break
                    end
                    @meta_data["frames"][index]["image"] = action_frames[index]
                end
                
                @number_of_frames = action_frames.length

            rescue 
                puts "Error: Unable to load action #{@meta_data["name"]}"
                @number_of_frames = @meta_data["frames"].length
            end

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
    
    def draw(x, y)
        begin               
            @meta_data["frames"][@current_frame]["image"].draw(x, y, 10)      
        rescue
        end
    end

    def button_down(id) 
        if id == Gosu::KB_ESCAPE
            close
        else
            super
        end
    end

end


if __FILE__==$0

    data = YAML.load(File.read("../actions/player actions/player_actions.yaml"))
    meta_data = data["attack_down_first"]
    sprite = meta_data["spritesheet"]
    
    p data.keys
    
    Action_player.new(100, -100, 10, meta_data).show
end
