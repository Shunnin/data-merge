module GBlendingData
  module Strategies
    class BaseStrategy

      attr_reader :merge_strategies, :compare_values

      # @param [Hash] merge_strategies     The merge strategies wil defined which data version will be prioritized
      # @param [Array<Any>] compare_values The compare value
      def initialize(merge_strategies, compare_values)
        @merge_strategies = merge_strategies
        @compare_values = compare_values
      end

      def execute
        process_validating
      end

      protected

      def strategy_type
        raise NotImplementedError
      end

      def process_validating
        raise NotImplementedError
      end

      def to_result(result)
        result ? 1 : 0
      end

    end
  end
end