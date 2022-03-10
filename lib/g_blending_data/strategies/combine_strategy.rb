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
        selected_value = Set.new
        temp_selected_value = Set.new

        # ['Outdoor Pool', 'indoor pool', 'pool']
        SortedSet[*@compare_values.flatten].each do |item|
          # Transform the string by downcase and removing specific character
          current_value = sanitize(item)

          # If have duplicate => not add to the selected value
          if temp_selected_value.none? { |v| v.include?(current_value) }
            temp_selected_value << current_value
            selected_value << item
          end
        end

        format_data(selected_value)
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