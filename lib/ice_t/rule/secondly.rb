module IceT
  module Rule
    class Secondly < Base
      class << self
        def to_i; 1.second.to_i end  
        def unit; :seconds end      
      end      
    end
  end
end