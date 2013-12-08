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
    module Rule

      def self.included(klass)
        klass.extend ClassMethods
      end

      def to_hash
        self.instance_values.symbolize_keys
      end

      module ClassMethods      
        def from_yaml(yaml_string)
          rule = YAML::load(yaml_string)
        end
      end
    end

    module Schedule
      def from_json(json_string)
        data = ActiveSupport::JSON.decode(json_string).symbolize_keys
        schedule = self.new(start_time: data[:start_time].to_time, end_time: data[:end_time].to_time)

        # TODO: use same builder of/for rules
        data[:rules]["rules"].each{ |rule|
          rule_class = rule['rule']
          interval = rule['interval'].to_i
          obj_rule = eval(rule_class + ".new(#{interval})")
          obj_rule.at = rule['at']
          schedule.add_rule(obj_rule)
        }
        
        schedule
      end   

      def from_yaml(yaml_string)
        schedule = YAML::load(yaml_string)
        return schedule if schedule.is_a?(IceT::Schedule)
      end

    end
  end
end