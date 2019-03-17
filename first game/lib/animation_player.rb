require 'yaml'

class Animation_player
    attr_accessor :current_frame_index
    def initialize(meta_data)
        begin
            

            @meta_data = meta_data

            spritesheet = meta_data["spritesheet"]
            img_width = @meta_data["size"][0]
            img_height = @meta_data["size"][1]
            animation_frames = Gosu::Image.load_tiles(spritesheet, img_width, img_height, tileable: true)

            animation_frames.each_with_index do |image, index|
                if @meta_data["frames"][index] == nil
                    puts "error: @meta_data[frames][#{index}] does not exist"
                    break
                end
                @meta_data["frames"][index]["image"] = animation_frames[index]
            end
            
            @number_of_frames = animation_frames.length
            @current_frame_index = 0
            @frames_delayed = 0

            @animation_playing = false

            @x_offset, @y_offset = @meta_data["offset"]
        rescue
            puts "error"
        end
    end
    
    def play
        @current_frame_index = 0
        @frames_delayed = 0
        @animation_playing = true
    end
    
    def stop
        @animation_playing = false
    end

    def update
        begin
            if @animation_playing
                if @frames_delayed < @meta_data["frames"][@current_frame_index]["display_time"]
                    @frames_delayed += 1
                else
                    @current_frame_index += 1
                    @frames_delayed = 0
                end
                @current_frame_index %= @number_of_frames 
            end
        rescue
        end
    end
    
    def draw(x, y)
        begin
            if @animation_playing                
                @meta_data["frames"][@current_frame_index]["image"].draw(x, y, 10)
            end
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

    data = YAML.load(File.read("../animations/player animations/player_animations.yaml"))
    meta_data = data["attack_down_first"]
    sprite = meta_data["spritesheet"]
    
    p data.keys
    
    Animation_player.new(100, -100, 10, meta_data).show
end
