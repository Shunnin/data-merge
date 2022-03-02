module GBlendingData
  module Strategies
    class CombineStrategy < BaseStrategy

      REGEX_ALLOW_SANITIZING_STRING = %r{[^a-z0-9]}.freeze

      protected

      def strategy_type
        :combine
      end

      def process_validating
        uniq_key = @merge_strategies[strategy_type].try(:[], :uniq_key)

        result = @compare_values.flatten.uniq do |item|
          item.is_a?(Hash) ? indicator_uniq_by(item, uniq_key) : sanitize(item)
        end

        format_data(result)
      end

      private

      def format_data(data)
        (data || []).map do |v|
          v.is_a?(String) ? v.strip.capitalize : v
        end
      end

      def sanitize(value)
        value.to_s.downcase.gsub(REGEX_ALLOW_SANITIZING_STRING, '')
      end

      def indicator_uniq_by(hash, uniq_key)
        return if uniq_key.nil?

        key = uniq_key.to_sym
        symbolized_hash = hash.symbolize_keys

        raise ArgumentError, "Invalid uniq_key: #{key}" unless symbolized_hash.has_key?(key)

        symbolized_hash[key]
      end

    end
  end
end