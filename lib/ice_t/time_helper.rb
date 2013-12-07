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
  end
end