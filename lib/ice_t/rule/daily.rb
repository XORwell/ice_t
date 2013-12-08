module IceT
  module Rule
    class Daily < Base
      class << self
        def to_i; 1.day.to_i end
        def unit; :days end
      end
      
      def to_s
        word = (@interval.eql?(2))? 'zweiten' : @interval
        # "jeden #{@interval} tage"
        "jeden #{word} tag"
      end

    end
  end
end