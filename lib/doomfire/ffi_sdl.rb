# frozen_string_literal: true

require 'fiddle'
require 'fiddle/import'

module Doomfire
  # very minimal FFI bindings for libSDL2
  module FFI_SDL
    extend Fiddle::Importer

    dlload 'libSDL2.dylib'

    typealias 'Uint32', :int
    typealias 'Uint16', :int
    typealias 'Uint8', :int

    SDL_INIT_VIDEO = 0x00000020
    SDL_WINDOW_OPENGL = 0x00000000
    SDL_WINDOWPOS_UNDEFINED = 0x1FFF0000 | 0
    SDL_WINDOWPOS_CENTERED = 0x2FFF0000 | 0
    SDL_QUIT = 0x100
    SDL_KEYDOWN = 0x300
    SDL_PIXELFORMAT_ARGB8888 = 0
    SDL_TEXTUREACCESS_STATIC = 0

    SDL_Event = union [
      'Uint32 type'
    ]

    SDL_Rect = struct [
      'int x',
      'int y',
      'int w',
      'int h'
    ]

    extern 'int SDL_Init(Uint32 flags)'
    extern 'void* SDL_CreateWindow(const char *title, int x, int y, int w, int h, Uint32 flags)'
    extern 'void* SDL_CreateRenderer(void* window, int index, Uint32 flags)'
    extern 'int SDL_WaitEvent(void* event)'
    extern 'int SDL_SetRenderDrawColor(void* renderer, Uint8 r, Uint8 g, Uint8 b, Uint8 a)'
    extern 'int SDL_RenderDrawPoint(void* renderer, int x, int y)'
    extern 'int SDL_RenderClear(void* renderer)'
    extern 'void SDL_RenderPresent(void* renderer)'
    extern 'void SDL_DestroyRenderer(void* renderer)'
    extern 'void SDL_DestroyWindow(void* window)'
    extern 'void SDL_Quit(void)'

    extern 'int SDL_UpdateTexture(void* texture, const void* rect, const void* pixels, int pitch)'
    extern 'int SDL_RenderCopy(void* renderer, void* texture, const void* srcrect, const void* dstrect)'
    extern 'void* SDL_CreateTexture(void* renderer, Uint32 format, int access, int w, int h)'
    extern 'void SDL_DestroyTexture(void* texture)'
    extern 'void* SDL_CreateRGBSurface(Uint32 flags, int width, int height, int depth, Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask)'
    extern 'int SDL_MapRGBA(void* fmt, int r, int g, int b, int a)'
    extern 'void* SDL_CreateTextureFromSurface(void* renderer, void* surface)'
    extern 'int SDL_LockSurface(void* surface);'
    extern 'void SDL_UnlockSurface(void* surface);'
  end
end
