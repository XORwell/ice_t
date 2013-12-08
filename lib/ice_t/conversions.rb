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
        
        options = {
          start_time: data[:start_time].to_time,
          end_time: data[:end_time].to_time
        }
        schedule = self.new(options)

        data[:rules]["rules"].each{ |rule|
          rule_class = rule['export_class_name']
          interval = rule['interval'].to_i
          at = rule['at']  
          init = if at.nil?
                   rule_class + ".new(#{interval})"
                 else
                   rule_class + ".new(#{interval}, '#{at}')"
                 end 
          obj_rule = eval(init)
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