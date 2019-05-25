# frozen_string_literal: true

require 'paint'

module Doomfire
  class Terminal
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

    FIRE_HEIGHT = 35

    def initialize
      @fire_width = Doomfire::WindowSize.new.terminal_width

      Paint.mode = 0xFFFFFF
      clear_screen

      initialize_pixels

      @exit_requested = false
      Kernel.trap('INT') { @exit_requested = true }
      @counter = 0
    end

    def run
      loop do
        if @exit_requested
          stop_fire if @counter.zero?
          break if @counter == FIRE_HEIGHT

          @counter += 1
        end

        update_pixels
        clear
        print_pixels
      end

      clear_screen
    end

    private

    def update_pixels
      (1...FIRE_HEIGHT).to_a.reverse.each do |x|
        (0...@fire_width).each do |y|
          spread_fire(x * @fire_width + y)
        end
      end
    end

    def initialize_pixels
      @pixels = []
      last_line = @fire_width * (FIRE_HEIGHT - 1)
      @pixels.fill(0, 0...last_line)
      @pixels.fill(34, last_line..(last_line + @fire_width))
    end

    def clear
      sleep 0.05
      puts "\e[34f\e[f"
    end

    def print_pixels
      (0...FIRE_HEIGHT).each do |x|
        (0...@fire_width).each do |y|
          print Paint[' ', nil, RGB[@pixels[x * @fire_width + y]]]
        end
        puts
      end
    end

    def clear_screen
      puts "\e[2J"
      puts "\e[H"
    end

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
  end
end
