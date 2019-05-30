# frozen_string_literal: true

require 'paint'

module Doomfire
  # This class outputs the pixels into the terminal, using ANSI color codes
  class Terminal < Base
    def run
      fire_loop
    end

    def stop
      @exit_requested = true
    end

    private

    def fire_loop
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

    def prepare_output
      @fire_width = Doomfire::WindowSize.new.terminal_width
      Paint.mode = 0xFFFFFF
      Kernel.trap('INT') { @exit_requested = true }
      clear_screen
    end

    def clear
      sleep 0.05
      puts "\e[34f\e[f"
    end

    def print_pixels
      (0...@fire_height).each do |x|
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
  end
end
