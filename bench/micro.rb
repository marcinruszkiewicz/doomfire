#!/usr/bin/env ruby

require 'fiddle'
require 'fiddle/import'

require 'doomfire'
require 'doomfire/ffi_sdl'
require 'doomfire/sdl'

require 'benchmark/ips'

class BaseBench < Doomfire::Base

  public :spread_fire, :update_pixels

  def prepare_output
    @fire_width = 80
    @fire_height = 35
  end

  def bench_spread_fire
    spread_fire(14 * @fire_width + 16)
  end

end

base_bench = BaseBench.new

module LibM
  extend Fiddle::Importer
  dlload 'libSystem.B.dylib'
  extern 'double floor(double)'
end

string = 'x' * 80 * 35

class SDLBench < Doomfire::SDL

  def initialize
    super
    @texdata = texdata
  end

  def prepare_output
    @fire_width = 80
    @fire_height = 35
  end

  def texdata
    @pixels.map { |val| ARGB[val] }
  end

  def texptr
    Fiddle::Pointer[@texdata.pack('L*')]
  end

end

sdl_bench = SDLBench.new

Benchmark.ips do |x|

  x.iterations = 3

  x.report('spread_fire') do
    base_bench.bench_spread_fire
  end

  x.report('update_pixels') do
    base_bench.update_pixels
  end

  x.report('call') do
    LibM.floor(14.2)
  end

  x.report('pointer') do
    Fiddle::Pointer[string]
  end

  x.report('texdata') do
    sdl_bench.texdata
  end
  
  x.report('texptr') do
    sdl_bench.texptr
  end

end
