module GBlendingData
  class MergingProcessor

      # @param [Hash] merge_strategies The merge strategies wil defined which data version will be prioritized
      # @param [Any] value             The compare value
      # @param [Array<Any>] temp_value The temp comparee value
    def initialize(merge_strategies, value, temp_value)
      @merge_strategies = merge_strategies
      @value = value
      @temp_value = temp_value
      @merge_result = []
    end

    def execute
      return [@value] if @merge_strategies.blank?

      compare_values = [@temp_value.last, @value]

      @merge_strategies.keys.each do |strategy_key|
        case strategy_key
        when :valid_format
          @merge_result << Strategies::ValidFormatStrategy.new(@merge_strategies, compare_values).execute
        when :text_matching
          @merge_result << Strategies::TextMatchingStrategy.new(@merge_strategies, compare_values).execute
        else
          raise StandardError, "Unsupported merge strategy: #{strategy_key}"
        end
      end

      get_final_result(compare_values)
    end

    private

    def get_final_result(compare_values)
      counter = @merge_result.reduce([0, 0]) do |acc, (v1, v2)|
        acc = [(acc[0].to_i + v1), (acc[1].to_i + v2)]
      end

      selected_index = counter.index(counter.max)

      compare_values[selected_index]
    end

  end
end