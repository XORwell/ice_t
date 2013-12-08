module IceT
  module Rule
    class Hourly < Base
      class << self
        def to_i; 1.hour.to_i end
        def unit; :hours end
      end
    end
  end
end