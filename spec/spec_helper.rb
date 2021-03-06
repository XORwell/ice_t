require 'rubygems'
require 'bundler/setup'
require 'coveralls'
Coveralls.wear!
require 'ice_t'


Dir.glob(File.expand_path("spec/support/**/*.rb")).each{ |f| require f }

RSpec.configure do |config|
  config.color_enabled = true

  config.tty = true

  config.formatter = :documentation # :progress, :html, :textmate
end