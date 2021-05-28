# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ice_t/version'

Gem::Specification.new do |spec|
  spec.name          = "ice_t"
  spec.version       = IceT::VERSION
  spec.authors       = ["Christian Nennemann"]
  spec.email         = ["christian.nennemann@gmail.com"]
  spec.description   = %q{IceT is a ruby library for handling repeated events}
  spec.summary       = %q{Ruby Time Recurrence}
  spec.homepage      = "https://github.com/XORwell/ice_t"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 4.0.0"
  #spec.add_dependency "i18n", ">= 0.6.5"

  spec.add_development_dependency "bundler", ">= 2.2.10"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

end
