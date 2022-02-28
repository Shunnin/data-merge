module GBlendingData
  module Strategies
    class TextMatchingStrategy < BaseStrategy

      REGEX_NORMAL_STRING = %r{[^a-z 0-9]}.freeze

      protected

      def strategy_type
        :text_matching
      end

      def process_validating
        return [0, 0] if !@merge_strategies[strategy_type]

        @compare_values.map.with_index do |v, i|
          j = (i - (@compare_values.count - 1)).abs
          v1 = sanitize(@compare_values[i])
          v2 = sanitize(@compare_values[j])

          to_result((v1 - v2).count > (v2 - v1).count)
        end
      end

      private

      def sanitize(string)
        string.to_s.downcase.gsub(REGEX_NORMAL_STRING, '').split(' ')
      end

    end
  end
end