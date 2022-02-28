module GBlendingData
  module Strategies
    class ValidFormatStrategy < BaseStrategy

      protected

      def strategy_type
        :valid_format
      end

      def process_validating
        regex = @merge_strategies[strategy_type]

        @compare_values.map { |v| to_result(v.to_s.match?(regex)) }
      end

    end
  end
end