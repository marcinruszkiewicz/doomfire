# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'doomfire/version'

Gem::Specification.new do |spec|
  spec.name          = 'doomfire'
  spec.version       = Doomfire::VERSION
  spec.authors       = ['Marcin Ruszkiewicz']
  spec.email         = ['marcin.ruszkiewicz@polcode.net']

  spec.summary       = 'Fire. In your console.'
  spec.description   = 'Puts your console on fire. Use a truecolor console for best effect.'
  spec.homepage      = 'https://github.com/marcinruszkiewicz/doomfire'
  spec.license       = 'MIT'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'paint'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'benchmark-ips', '~> 2.7'
end
