class Foo
    attr_accessor :bar

    @@bar = "lollolS"
    def initialize(var)
        @bar = var
    end

    def lol
        return @bar + @bar
    end

    def bar= value
        raise "Noob" if value == nil
        @bar = value
    end
end 


class GameObject
    attr_reader :x,:y,:width,:height
end

class Enemy < GameObject
end

class Player < GameObject
end

class Wall < GameObject
end

a = Foo.new("omg")

begin
    a.bar = nil
rescue StandardError => e
    puts "You done fucked up"
end