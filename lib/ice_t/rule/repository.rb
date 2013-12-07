require 'forwardable'

module IceT
  module Rule
    class Repository
      extend Forwardable
      def_delegators :@rules, :empty?, :size, :first, :last, :collect

      attr_reader :rules

      def initialize
        @rules = []      
      end

      def add(rule)
        @rules << rule unless rule.nil?
      end

      def remove(rule)
        @rules.delete(rule)
      end

    end    
  end
end