require "ice_t/version"

# TODO: be more specific instead including all..
require 'active_support/all'


module IceT
  I18n.load_path += Dir[File.expand_path('../locales/*{rb,yml}', __FILE__)]

  require 'ice_t/exceptions'

  require 'ice_t/time_helper'
  
  require 'ice_t/conversions'
  require 'ice_t/rule'
  require 'ice_t/collection'

  # module Rule
  #   autoload :Repository, 'ice_t/rule/repository'
  # end
end
