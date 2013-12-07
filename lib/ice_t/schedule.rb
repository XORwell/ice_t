require 'forwardable'

module IceT
  class Schedule
    
    extend Forwardable    
    def_delegator :@rules, :add, :add_rule
    def_delegator :@rules, :remove, :remove_rule
    def_delegator :@rules, :rules, :rules

    extend IceT::Conversions::Schedule

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