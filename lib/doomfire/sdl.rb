# frozen_string_literal: true

require 'pry'

module Doomfire
  # Output to a separate SDL window
  class SDL < Base
    extend Doomfire::FFI_SDL

    ARGB = [
      0x00000000,
      0x00070707,
      0xFF1F0707,
      0xFF2F0F07,
      0xFF571707,
      0xFF671F07,
      0xFF771F07,
      0xFF8F2707,
      0xFF9F2F07,
      0xFFAF3F07,
      0xFFBF4707,
      0xFFC74707,
      0xFFDF4F07,
      0xFFDF5707,
      0xFFDF5707,
      0xFFD7670F,
      0xFFCF6F0F,
      0xFFCF770F,
      0xFFCF7F0F,
      0xFFCF8717,
      0xFFC78717,
      0xFFC78F17,
      0xFFC7971F,
      0xFFBF9F1F,
      0xFFBF9F1F,
      0xFFBFA727,
      0xFFBFA727,
      0xFFBFAF2F,
      0xFFB7AF2F,
      0xFFB7B72F,
      0xFFB7B737,
      0xFFCFCF6F,
      0xFFDFDF9F,
      0xFFEFEFC7,
      0xFFFFFFFF
    ].freeze

    def run
      fire_loop
    end

    def stop
      @exit_requested = true
    end

    private

    def fire_loop
      loop do
        next if @event.nil? || @window.nil? || @renderer.nil? || @texture.nil?

        FFI_SDL.SDL_PollEvent(@event)
        @exit_requested = true if @event.type == FFI_SDL::SDL_QUIT

        if @exit_requested
          stop_fire if @counter.zero?
          break if @counter == 60

          @counter += 1
        end

        clear
        update_pixels
        print_pixels
      end

      clear_screen
    end

    def update_pixels
      (0..@fire_width).each do |x|
        (1...@fire_height).each do |y|
          spread_fire(y * @fire_width + x)
        end
      end

      @texdata = @pixels.map { |val| ARGB[val] }
      @texptr = Fiddle::Pointer[@texdata.pack('L*')]
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
      @texture = FFI_SDL.SDL_CreateTexture(
        @renderer,
        FFI_SDL::SDL_PIXELFORMAT_ARGB8888,
        FFI_SDL::SDL_TEXTUREACCESS_STREAMING,
        @fire_width,
        @fire_height
      )
      @event = FFI_SDL::SDL_Event.malloc
    end

    def clear
      FFI_SDL.SDL_RenderClear(@renderer)
    end

    def print_pixels
      FFI_SDL.SDL_UpdateTexture(@texture, nil, @texptr, 4 * @fire_width)
      FFI_SDL.SDL_RenderCopy(@renderer, @texture, 0, 0)
      FFI_SDL.SDL_RenderPresent(@renderer)
    end

    def clear_screen
      FFI_SDL.SDL_Quit()
    end
  end
end
