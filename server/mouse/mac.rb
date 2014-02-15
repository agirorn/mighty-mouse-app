module Mouse
  class Mac
    attr_reader :speed
    def initialize(speed)
      @speed = speed
    end

    # Move!
    def move(x,y)
      x = x.to_i * speed
      y = y.to_i * speed
      x = revers_number(x)
      y = revers_number(y)

      x = ensure_pluss(x)
      y = ensure_pluss(y)

      cmd = "cliclick -m verbose 'm:#{x},#{y}'"
      puts cmd
      system cmd
    end

    # Click!
    def click
      system "cliclick -m verbose 'c:.'"
    end

    private

    def revers_number(number)
      number - number - number
    end

    def ensure_pluss(number)
      number = number.to_s
      unless number.match(/^\-/)
        number = '+' + number
      end
      number
    end
  end
end
