require_relative 'game_object.rb'



class Enemies < Game_object
    attr_accessor :x, :y, :type

    def initialize(x= 0, y= 0, type= default)
        @x = x
        @y = y
        @type = type 

        @@enemy_types = [default, wolf, archer, assasin, someting]
    end



end