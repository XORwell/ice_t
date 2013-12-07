module IceT
  module Rule
    class Minutely < Base
      class << self
        def to_i; 1.minute.to_i end
      end
    end
  end
end