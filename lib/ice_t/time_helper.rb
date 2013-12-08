module IceT
  module TimeHelper
    module_function
    #
    # Returns diff of two date by given unit
    # @param Time start_time
    # @param Time end_time
    # @param Symbol unit
    # @param Boolean round 
    # @return Integer|Float diff
    def diff_by_unit(start_time, end_time, unit = :days, round = true)
      diff = ((end_time - start_time) / eval("1.#{unit}"))
      diff = (round) ? diff.round : diff
    end
  end
end