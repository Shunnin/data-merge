module GBlendingData
  class DataTransform

    def initialize(raw_data, configs, callback_success:)
      @raw_data = raw_data
      @configs = configs
      @callback_success = callback_success
    end

    def execute
      return if @raw_data.blank?

      if @raw_data.count == 1
        # NOTE: Double-check
        handle_blending_data_success(@raw_data.last)
      else
        result = {}

        @configs.each do |key, conf|
          temp = []
          @raw_data.each { |data| blend_data(data[key.to_s], temp, conf) }

          result[key] = temp.last if temp.present?
        end

        handle_blending_data_success(result)
      end
    end

    private

    def blend_data(value, temp, conf)
      return if value.blank?

      if temp.present?
        temp = MergingProcessor.new(conf[:merge_strategies], value, temp).execute
      else
        temp << value
      end
    end

    def handle_blending_data_success(result)
      return if @callback_success.nil?

      @callback_success.call(result)
    end

  end
end