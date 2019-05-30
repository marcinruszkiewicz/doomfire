# frozen_string_literal: true

module Doomfire
  # Base class for the fire algorithm
  class Base
    RGB = [
      [0, 0, 0],
      [7, 7, 7],
      [31, 7, 7],
      [47, 15, 7],
      [87, 23, 7],
      [103, 31, 7],
      [119, 31, 7],
      [143, 39, 7],
      [159, 47, 7],
      [175, 63, 7],
      [191, 71, 7],
      [199, 71, 7],
      [223, 79, 7],
      [223, 87, 7],
      [223, 87, 7],
      [215, 103, 15],
      [207, 111, 15],
      [207, 119, 15],
      [207, 127, 15],
      [207, 135, 23],
      [199, 135, 23],
      [199, 143, 23],
      [199, 151, 31],
      [191, 159, 31],
      [191, 159, 31],
      [191, 167, 39],
      [191, 167, 39],
      [191, 175, 47],
      [183, 175, 47],
      [183, 183, 47],
      [183, 183, 55],
      [207, 207, 111],
      [223, 223, 159],
      [239, 239, 199],
      [255, 255, 255]
    ].freeze

    attr_reader :exit_requested, :pixels, :fire_width

    def initialize
      @counter = 0
      @thread = nil
      @exit_requested = false

      prepare_output

      initialize_pixels
    end

    def run
      raise NotImplementedError
    end

    def stop
      raise NotImplementedError
    end

    private

    def spread_fire(src)
      if @pixels[src].zero?
        @pixels[src - @fire_width] = 1
      else
        random = rand(10).round & 3
        dst = src - rand(3) + 1
        @pixels[dst - @fire_width] = @pixels[src] - (random & 1)
      end
    end

    def stop_fire
      @pixels.pop(@fire_width)
      @pixels.concat [].fill(0, 0, @fire_width)
    end

    def update_pixels
      (1...@fire_height).to_a.reverse.each do |x|
        (0...@fire_width).each do |y|
          spread_fire(x * @fire_width + y)
        end
      end
    end

    def initialize_pixels
      @pixels = []
      last_line = @fire_width * (@fire_height - 1)
      @pixels.fill(0, 0...last_line)
      @pixels.fill(34, last_line..(last_line + @fire_width))
    end

    def prepare_output
      @fire_width = 80
      @fire_height = 35
    end

    def fire_loop
      raise NotImplementedError
    end

    def clear
      raise NotImplementedError
    end

    def clear_screen
      raise NotImplementedError
    end

    def print_pixels
      raise NotImplementedError
    end
  end
end
