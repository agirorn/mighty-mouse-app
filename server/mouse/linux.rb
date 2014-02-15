module Mouse
  class Linux
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

      cmd = "xdotool mousemove_relative #{x} #{y}"
      puts cmd
      system cmd
    end

    # Click!
    def click
      cmd = "xdotool click"
      system cmd
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
