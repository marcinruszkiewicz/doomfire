# frozen_string_literal: true

require 'fiddle'
require 'fiddle/import'

module Doomfire
  # very minimal FFI bindings for libSDL2
  module FFI_SDL
    extend Fiddle::Importer

    dlload "libSDL2.#{Platform.lib_ext}"

    typealias 'Uint32', :int
    typealias 'Uint16', :int
    typealias 'Uint8', :int

    SDL_INIT_VIDEO = 0x00000020
    SDL_WINDOW_OPENGL = 0x00000000
    SDL_WINDOWPOS_UNDEFINED = 0x1FFF0000 | 0
    SDL_WINDOWPOS_CENTERED = 0x2FFF0000 | 0
    SDL_QUIT = 0x100
    SDL_KEYDOWN = 0x300
    SDL_PIXELFORMAT_ARGB8888 = 372_645_892
    SDL_TEXTUREACCESS_STREAMING = 1

    SDL_Event = union [
      'Uint32 type'
    ]

    # basic SDL functions - creating windows, events etc
    extern 'int SDL_Init(Uint32 flags)'
    extern 'void* SDL_CreateWindow(const char *title, int x, int y, int w, int h, Uint32 flags)'
    extern 'void* SDL_CreateRenderer(void* window, int index, Uint32 flags)'
    extern 'int SDL_PollEvent(void* event)'
    extern 'int SDL_RenderClear(void* renderer)'
    extern 'void SDL_RenderPresent(void* renderer)'
    extern 'void SDL_Quit(void)'

    # software-accelerated rendering
    extern 'int SDL_SetRenderDrawColor(void* renderer, Uint8 r, Uint8 g, Uint8 b, Uint8 a)'
    extern 'int SDL_RenderDrawPoint(void* renderer, int x, int y)'

    # textures are hardware accelerated
    extern 'void* SDL_CreateTexture(void* renderer, Uint32 format, int access, int w, int h)'
    extern 'int SDL_RenderCopy(void* renderer, void* texture, const void* srcrect, const void* dstrect)'
    extern 'int SDL_UpdateTexture(void* texture, const void* rect, const void* pixels, int pitch)'
  end
end
