require 'date'
require 'forwardable'


module IceT
  # defines a method for each weekday
  # which takes two params (start_date, end_date)
  # and return the all days which occure on this wday
  module WeekdayMethods
    def self.included(klass)
      klass.instance_eval do
        IceT::TimeHelper::PLURALIZED_DAYNAMES.each do |wday|
          define_method(wday) { |start_time, end_time|
            occurrences(start_time, end_time)
              .select(&IceT::TimeHelper.question_mark_dayname(wday)) 
          }
        end
      end
    end
  end
end


module IceT
  class Collection

    include IceT::WeekdayMethods

    extend Forwardable 

    attr_reader :rules

    def initialize
      @rules = []
    end

    def_delegator :@rules, :delete, :remove_rule

    def add_rule(rule)
      @rules << rule unless @rules.include?(rule)
    end

    def occurrences(start_time, end_time)
      @rules.collect{ |rule| 
        rule.occurrences(start_time, end_time) 
      }.flatten
       .uniq
    end

  end
end