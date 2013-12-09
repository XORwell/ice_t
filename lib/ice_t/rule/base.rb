#--
# Copyright (c) 2013 Christian Nennemann
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

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

      def initialize(interval = 1)
        raise ArgumentError.new('Positive integer required') if interval.nil? ||
                                                                interval.to_i < 1 ||
                                                                interval % 1 != 0
        @rule = self.class.name
        @interval = interval
      end

      include Comparable
      def <=>(other)
        return unless other.class.respond_to?(:to_i)
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

      def to_s
        I18n.t "ice_t.each_#{self.class.unit[0..-2]}", count: self.interval
      end
    end
  end
end