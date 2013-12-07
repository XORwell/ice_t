module IceT
  module Rule
    class Daily < Base
      class << self
        def to_i; 1.day.to_i end
      end
      
      def occurrences(start_time, end_time)
        (start_time.to_date..end_time.to_date).step(self.interval).to_a.map(&:to_time)
      end

      def to_s
        word = (@interval.eql?(2))? 'zweiten' : @interval
        # "jeden #{@interval} tage"
        "jeden #{word} tag"
      end

    end
  end
end