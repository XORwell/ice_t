require 'rubygems'
require 'bundler/setup'
require 'coveralls'
require 'ice_t'

Coveralls.wear!

Dir.glob(File.expand_path("spec/support/**/*.rb")).each{ |f| require f }

RSpec.configure do |config|
  config.color_enabled = true

  config.tty = true

  config.formatter = :documentation # :progress, :html, :textmate
end