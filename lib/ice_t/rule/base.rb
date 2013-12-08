module IceT
  module Rule
    class Base

      class << self
        include Comparable
        def <=>(other)
          self.to_i <=> other.to_i
        end
      end

      include IceT::Conversions::Rule

      attr_reader :interval
      attr_reader :at

      def initialize(interval = 1, at_str = nil)
        raise ArgumentError.new('Positive integer required') if interval.nil? ||
                                                                interval.to_i < 1 ||
                                                                interval % 1 != 0
        @interval = interval
        @at = at_str
        @rule = self.class.name
        self.at = at_str unless @at.nil?
      end

      # set time information
      def at=(str)
        return if str.nil?
        if Time.parse(str.to_s)
          @at = str.to_s
        end
      end

      include Comparable
      def <=>(other)
        if self.class == other.class
          case
          when self.interval == other.interval
            0
          when self.interval < other.interval
            -1 
          when self.interval > other.interval
            +1
          end
        else
          case 
          when self.class.to_i < other.class.to_i
            -1
          when self.class.to_i > other.class.to_i
            +1
          end
        end
      end

      def occurrences(start_time, end_time)
        diff = IceT::TimeHelper.diff_by_unit(start_time, end_time, self.class.unit)
        (0..diff).step(self.interval).map { |i|
          start_time.advance(self.class.unit => i)
        }
      end

    end
  end
end