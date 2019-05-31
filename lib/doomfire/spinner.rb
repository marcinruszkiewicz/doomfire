# frozen_string_literal: true

module Doomfire
  # Same output as the Terminal class, but this runs in a separate thread,
  # so the main process can continue with its work
  class Spinner < Terminal
    def run
      @thread = Thread.start { fire_loop }
    end

    def stop
      @exit_requested = true
      @thread.join
    end

    private

    def prepare_output
      @fire_height = 35
      @fire_width = Doomfire::WindowSize.new.terminal_width
      Paint.mode = 0xFFFFFF
      clear_screen
    end
  end
end
