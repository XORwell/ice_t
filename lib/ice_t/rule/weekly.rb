module IceT
  module Rule
    class Weekly < Base
      class << self
        def to_i; 1.week.to_i end  
        def unit; :weeks end      
      end      
    end
  end
end