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