![Build Status](https://github.com/marcinruszkiewicz/doomfire/actions/workflows/rspec.yml/badge.svg)
[![Gem Version](https://badge.fury.io/rb/doomfire.svg)](https://badge.fury.io/rb/doomfire)

# Doomfire

Put your terminal on fire.

![terminal example](examples/terminal.png)

This gem implements the [Doom fire algorithm](https://fabiensanglard.net/doom_fire_psx/) in Ruby, because why not, and outputs it into the terminal. Right now it requires the terminal to be able to display 24-bit colors, so it will either not work at all or not work properly on terminals that can't do that, for example on MacOS's default `Terminal.app` - in which case you should probably install a better terminal application (like [iTerm](https://www.iterm2.com) or whatever else you like).

You can check the list of terminals supporting 24-bit color [here](https://github.com/termstandard/colors).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'doomfire'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install doomfire

## Usage

The most basic way to run this is to run it directly from the command line:

    $ doomfire

Pressing `CTRL`-`C` will stop the program gracefully after a few extra frames to let it end nicely.

Alternatively you can use it for amusement while running some long rake tasks.

```ruby
require 'doomfire'

desc 'some long running task'
task :long do
  fire = Doomfire::Spinner.new
  fire.run

  5.times do
    sleep 1
  end

  fire.stop
end
```

This will run the fire in a separate thread while your rake tasks works in the main thread, and at the end of the task it will gracefully extinguish the fire and clear the terminal.

## SDL

Now with actual pixel manipulation! You can set the output to use the SDL2 library, which will put the output in a graphical window. It's a bit restricted right now to a small window and sometimes blows up, so I consider it a bit of an experiment.

You need [libSDL2](http://www.libsdl.org/download-2.0.php) installed on your system (most likely through Homebrew, apt or whatever your system uses). The doomfire executable script will complain if you don't have it.

    $ brew install sdl2

Then you can run the executable:

    $ doomfire --sdl

And the output should be shown in a separate window. Closing the window will end the program after a few seconds of the ending animation.

![SDL example](examples/sdl.png)

If running on a Ruby interpreter on the JVM, you will need the `-XstartOnFirstThread` option.

## Benchmarks

    $ bundle exec bench/micro.rb
    $ bundle exec bench/macro.rb

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/marcinruszkiewicz/doomfire.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
