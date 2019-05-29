require 'fiddle'
require 'fiddle/import'
require 'pry'

module SDL
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

  extern 'int SDL_Init(Uint32 flags)'
  extern 'void* SDL_CreateWindow(const char *title, int x, int y, int w, int h, Uint32 flags)'
  extern 'void* SDL_CreateRenderer(void* window, int index, Uint32 flags)'
  extern 'void* SDL_CreateTexture(void* renderer, Uint32 format, int access, int w, int h)'
  extern 'int SDL_WaitEvent(void* event)'
  extern 'void SDL_Quit(void)'
  extern 'void SDL_DestroyWindow(void* window)'
  extern 'void SDL_DestroyRenderer(void* renderer)'
  extern 'void SDL_DestroyTexture(void* texture)'
end

# https://dzone.com/articles/sdl2-pixel-drawing
# http://wiki.libsdl.org/SDL_Init
# https://github.com/davidsiaw/SDL2/blob/master/include/SDL_stdinc.h
# http://ruby-doc.org/stdlib-2.6.3/libdoc/fiddle/rdoc/Fiddle.html#method-c-dlopen
# https://www.honeybadger.io/blog/use-any-c-library-from-ruby-via-fiddle-the-ruby-standard-librarys-best-kept-secret/
# https://bitbucket.org/dandago/gigilabs/src/master/Sdl2PixelDrawing/Sdl2PixelDrawing/main.cpp

SDL.SDL_Init(SDL::SDL_INIT_VIDEO)
window = SDL.SDL_CreateWindow("Doomfire.rb", SDL::SDL_WINDOWPOS_UNDEFINED, SDL::SDL_WINDOWPOS_UNDEFINED, 640, 480, SDL::SDL_WINDOW_OPENGL)
renderer = SDL.SDL_CreateRenderer(window, -1, 0)
texture = SDL.SDL_CreateTexture(renderer, SDL::SDL_PIXELFORMAT_ARGB8888, SDL::SDL_TEXTUREACCESS_STATIC, 640, 480)

event = SDL::SDL_Event.malloc
quit = false

until quit
  SDL.SDL_WaitEvent(event)

  quit = true if event.type == SDL::SDL_QUIT
end
