require 'paint'
require 'pry'

RGB = [
  [7, 7, 7],
  [31, 7, 7],
  [47, 15, 7],
  [87, 23, 7],
  [103, 31, 7],
  [119, 31, 7],
  [143, 39, 7],
  [159, 47, 7],
  [175, 63, 7],
  [191, 71, 7],
  [199, 71, 7],
  [223, 79, 7],
  [223, 87, 7],
  [223, 87, 7],
  [215, 103, 15],
  [207, 111, 15],
  [207, 119, 15],
  [207, 127, 15],
  [207, 135, 23],
  [199, 135, 23],
  [199, 143, 23],
  [199, 151, 31],
  [191, 159, 31],
  [191, 159, 31],
  [191, 167, 39],
  [191, 167, 39],
  [191, 175, 47],
  [183, 175, 47],
  [183, 183, 47],
  [183, 183, 55],
  [207, 207, 111],
  [223, 223, 159],
  [239, 239, 199],
  [255, 255, 255]
]

FIRE_HEIGHT = 34
FIRE_WIDTH = 80

def clear
  sleep 0.1
  puts "\e[34f\e[f"
end

def print_and_flush
  (0...FIRE_HEIGHT).each do |x|
    (0...FIRE_WIDTH).each do |y|
      print Paint[' ', nil, RGB[@pixels[x * FIRE_WIDTH + y]]]
    end
    puts
  end
end

def clear_screen
  puts "\e[2J"
end

def spread_fire(src)
  random = rand(10).round & 3
  dst = src - rand(3) + 1
  @pixels[dst - FIRE_WIDTH] = @pixels[src] - (random & 1)
  # @pixels[src - FIRE_WIDTH] = @pixels[src] - 1
end

Paint.mode = 0xFFFFFF
clear_screen

@pixels = []
last_line = FIRE_WIDTH * (FIRE_HEIGHT - 1)
@pixels.fill(0, 0...last_line)
@pixels.fill(33, last_line..(last_line + FIRE_WIDTH))

# 10.times do
while true
  (1...FIRE_HEIGHT).to_a.reverse.each do |x|
    (0...FIRE_WIDTH).each do |y|
      spread_fire(x * FIRE_WIDTH + y)
    end
  end

  clear
  print_and_flush
end

# clear_screen
# puts "\e[H"
