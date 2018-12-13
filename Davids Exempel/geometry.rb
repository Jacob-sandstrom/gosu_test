class Point
    attr_accessor :x,:y

    def initialize(x=0,y=0)
        @x = x
        @y = y
    end

end

point1 = Point.new(50,20)
point2 = Point.new(90,12)

puts point1.methods
