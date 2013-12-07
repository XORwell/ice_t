module IceT
  module TimeHelper
    module_function
    #
    # Returns number of months between two times
    # @param  start_time [Time]
    # @param  end_time [Time]
    #
    # @return [Fixum] months
    def get_months_between(start_time, end_time)
      (end_time.year * 12 + end_time.month) - (start_time.year * 12 + start_time.month)
    end


    def human_understanding_of_time_equality(a, b)
      int_a = a.interval
      int_b = b.interval
      case

      when a.is_a?(IceT::Rules::YearlyRule) && b.is_a?(IceT::Rules::MonthlyRule)
           return (int_a.to_f / int_b.to_f) == 0.08333333333333333
      when a.is_a?(IceT::Rules::YearlyRule) && b.is_a?(IceT::Rule::Daily)
           return (int_a.to_f / int_b.to_f) == 0.03287671232876712
           
      # when a.is_a?(IceT::Rules::YearlyRule) && b.is_a?(IceT::Rule::Minutely)
      #      return (int_a.to_f / int_b.to_f) == 0.03287671232876712


      when a.is_a?(IceT::Rules::MonthlyRule) && b.is_a?(IceT::Rules::YearlyRule)
           return (int_a / int_b) == 12

      when a.is_a?(IceT::Rule::Daily) && b.is_a?(IceT::Rules::YearlyRule)
           return (int_a / int_b) == 365
      
      else
        return false
      end

    end
    def human_understanding_of_date_equality
      return "fireball"
    end
    

  end
end