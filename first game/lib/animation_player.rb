require 'yaml'
require 'Gosu'

class Animation_player < Gosu::Window
    def initialize(x, y, z, meta_data)
        begin
            width = 400
            height = 800
            super width, height

            @meta_data = meta_data
            @x = x
            @y = y
            @z = z

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

            @animation_playing = true

            @x_offset, @y_offset = @meta_data["offset"]
        rescue

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
                @x += @meta_data["frames"][@current_frame_index]["x_movement"]
                @y += @meta_data["frames"][@current_frame_index]["y_movement"]
            end
        rescue
        end
    end
    
    def draw
        begin
            if @animation_playing                
                @meta_data["frames"][@current_frame_index]["image"].draw(@x + @x_offset, @y + @y_offset, @z)
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
    meta_data = data["attack_down"]
    sprite = meta_data["spritesheet"]
    
    p data.keys
    
    Animation_player.new(100, -100, 10, meta_data).show
end
