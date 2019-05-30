# frozen_string_literal: true

require 'pry'

module Doomfire
  # Output to a separate SDL window
  class SDL < Base
    extend Doomfire::FFI_SDL

    def run
      fire_loop
    end

    def stop
      @exit_requested = true
    end

    private

    def fire_loop
      loop do
        next if @event.nil? || @window.nil? || @renderer.nil?

        FFI_SDL.SDL_WaitEvent(@event)
        @exit_requested = true if @event.type == FFI_SDL::SDL_QUIT

        break if @exit_requested
        # if @exit_requested
        #   stop_fire if @counter.zero?
        #   break if @counter == FIRE_HEIGHT

        #   @counter += 1
        # end

        clear
        update_pixels
        print_pixels
      end

      clear_screen
    end

    def prepare_output
      @fire_width = 640
      @fire_height = 480

      FFI_SDL.SDL_Init(FFI_SDL::SDL_INIT_VIDEO)
      @window = FFI_SDL.SDL_CreateWindow(
        'Doomfire.rb',
        FFI_SDL::SDL_WINDOWPOS_UNDEFINED,
        FFI_SDL::SDL_WINDOWPOS_UNDEFINED,
        @fire_width,
        @fire_height,
        FFI_SDL::SDL_WINDOW_OPENGL
      )
      @renderer = FFI_SDL.SDL_CreateRenderer(@window, -1, 0)
      # @texture = FFI_SDL.SDL_CreateTexture(
      #   @renderer,
      #   FFI_SDL::SDL_PIXELFORMAT_ARGB8888,
      #   FFI_SDL::SDL_TEXTUREACCESS_STREAMING,
      #   @fire_width,
      #   @fire_height
      # )
      @event = FFI_SDL::SDL_Event.malloc
    end

    def clear
      FFI_SDL.SDL_RenderClear(@renderer)
    end

    def print_pixels
      (0...@fire_width).each do |x|
        (0...@fire_height).each do |y|
          rgb_val = RGB[@pixels[y * @fire_width + x]]

          FFI_SDL.SDL_SetRenderDrawColor(@renderer, rgb_val[0], rgb_val[1], rgb_val[2], 255)
          FFI_SDL.SDL_RenderDrawPoint(@renderer, x, y)
        end
      end
      FFI_SDL.SDL_RenderPresent(@renderer)
    end

    def clear_screen
      FFI_SDL.SDL_DestroyRenderer(@renderer)

      FFI_SDL.SDL_DestroyWindow(@window)
      FFI_SDL.SDL_Quit()
    end
  end
end
