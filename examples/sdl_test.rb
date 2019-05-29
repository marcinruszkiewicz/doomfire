require 'fiddle'
require 'fiddle/import'

module SDL
  extend Fiddle::Importer

  dlload 'libSDL2.dylib'

  SDL_INIT_VIDEO = 0x00000020

  typealias 'Uint32', :int
  extern 'int SDL_Init(Uint32 flags)'
end

# https://dzone.com/articles/sdl2-pixel-drawing
# http://wiki.libsdl.org/SDL_Init
# https://github.com/davidsiaw/SDL2/blob/master/include/SDL_stdinc.h
# http://ruby-doc.org/stdlib-2.6.3/libdoc/fiddle/rdoc/Fiddle.html#method-c-dlopen
# https://www.honeybadger.io/blog/use-any-c-library-from-ruby-via-fiddle-the-ruby-standard-librarys-best-kept-secret/

SDL.SDL_Init(SDL::SDL_INIT_VIDEO)
