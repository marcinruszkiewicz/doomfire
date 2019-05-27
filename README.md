# Doomfire

Put your terminal on fire.

![doomfire gif](https://gfycat.com/pl/blindancienthammerheadbird)

This gem implements the Doom fire algorithm in Ruby, because why not, and outputs it into the terminal. Right now it requires the terminal to be able to display 24-bit colors, so it will either not work at all or not work properly on terminals that can't do that, for example on MacOS's default `Terminal.app` - in which case you should probably install a better terminal application (like [iTerm](https://www.iterm2.com) or whatever else you like).

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

First way to run this is to run it directly from the command line:

    $ doomfire

Pressing `CTRL`-`C` will stop the program gracefully after a few extra frames.

Alternatively you can use it for amusement while running some long rake tasks - see `examples/long.rake`. In short, what you need to do is to instantiate and start the fire at the start of the task:

```ruby
fire = Doomfire::Terminal.new
fire.run
```

And then after your task is done:

```ruby
fire.stop
```

This will run the fire in a separate thread while your rake tasks works in the main thread.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/marcinruszkiewicz/doomfire.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
