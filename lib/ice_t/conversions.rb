#--
# Copyright (c) 2013 Christian Nennemann
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

module IceT
  module Conversions
    # module Helper
    #   module_function
    #   def recursive_instance_values(object)
    #   end
    # end
    
    module Common
      module InstanceMethods
      end
      module ClassMethods
        def from_yaml(yaml_string)
          YAML::load(yaml_string)
        end
      end
    end

    module Rule

      def self.included(klass)
        klass.extend ClassMethods
      end
      
      def to_hash
        self.instance_values.symbolize_keys
      end        

      module ClassMethods      
        def from_yaml(yaml_string)
          YAML::load(yaml_string)
        end
        def from_json(json_string)
          hash = ActiveSupport::JSON.decode(json_string).symbolize_keys
          self.from_hash(hash)
        end
        def from_hash(hash)
          rule_class = hash[:rule]
          interval   = hash[:interval].to_i          
          eval(rule_class + ".new(#{interval})")
        end
      end
    end

    module Schedule
      
      def self.included(klass)
        klass.extend ClassMethods
      end

      module ClassMethods
        def from_yaml(yaml_string)
          YAML::load(yaml_string)
        end

        def from_json(json_string)
          return unless json_string
          data = ActiveSupport::JSON.decode(json_string).symbolize_keys
          schedule = self.new(start_time: data[:start_time].to_time, end_time: data[:end_time].to_time)
          data[:rules]["rules"].each{ |rule|
            schedule.add_rule(
              IceT::Rule::Base.from_json(rule.to_json)
            )
          }        
          schedule
        end   
      end
    end

  end
end