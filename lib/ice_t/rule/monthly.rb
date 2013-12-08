module IceT
  module Rule
    class Monthly < Base
      class << self
        def to_i; 1.month.to_i end  
        def unit; :months end      
      end      
    end
  end
end