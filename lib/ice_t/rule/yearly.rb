module IceT
  module Rule
    class Yearly < Base
      class << self
        def to_i; 1.year.to_i end        
      end
    end
  end
end