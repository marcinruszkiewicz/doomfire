#!/usr/bin/env ruby

require 'doomfire'
require 'doomfire/ffi_sdl'
require 'doomfire/sdl'

# Benchmark of the whole of Doomfire running in SDL mode. Prints FPS to
# the screen every second. Manually observe the warmup curve before taking
# a reading.

puts 'Wait for FPS to stabilise before taking a reading...'

class Bench < Doomfire::SDL

  def print_pixels
    super
    record_frame
  end

  def record_frame
    time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    if @start.nil?
      @start = time
      @frames = 0
    end

    @frames += 1
    elapsed = time - @start

    if elapsed > 1
      printf "%.2f fps\n", @frames / elapsed
      @start = time
      @frames = 0
    end
  end

end

Bench.new.run
