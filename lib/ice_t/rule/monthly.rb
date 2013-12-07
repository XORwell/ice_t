module IceT
  module Rule
    class Monthly < Base
      
      class << self
        def to_i; 1.month.to_i end        
      end

      include IceT::TimeHelper
      
      def occurrences(start_time, end_time)
        total_months_between = get_months_between(start_time, end_time)
        advanceable_months   = (1..total_months_between).step(self.interval)        
        advanceable_months.map { |i| start_time.advance(:months => i) }
      end


      private



      def ajusted_day(time)
        unless @at.nil?
          t = Time.parse(@at)
        end
      end
    end
  end
end