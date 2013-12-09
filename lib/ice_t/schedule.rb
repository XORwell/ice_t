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

require 'forwardable'

module IceT
  class Schedule
    
    extend Forwardable    
    def_delegator :@rules, :add, :add_rule
    def_delegator :@rules, :remove, :remove_rule
    def_delegator :@rules, :rules, :rules

    include IceT::Conversions::Schedule

    attr_reader :start_time
    attr_reader :end_time

    def initialize(opts={})
      opts = {
        start_time: nil,
        end_time: nil
      }.merge(opts)
      @start_time = opts[:start_time]
      @end_time   = opts[:end_time]

      @rules = IceT::Rule::Repository.new
    end
    
    def occurrences
      return [] if @rules.empty?
      
      # TODO: better error message      
      fail('this needs start_time and end_time') if @start_time.nil? && @end_time.nil?

      @rules.collect{ |rule|
        rule.occurrences(@start_time, @end_time)
      }.flatten
    end

  end
end