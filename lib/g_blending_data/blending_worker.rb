module GBlendingData
  class BlendingWorker

    def initialize(source_ids)
      @source_ids = source_ids
    end

    def execute
      return if @source_ids.blank?

      @source_ids.each do |id|
        noise_hotel = get_noise_data(id)

        GBlendingData::DataTransform.new(
          noise_hotel,
          config,
          callback_success: ->(result) { handle_blending_success(result) },
        ).execute
      end
    end

    protected

    def get_noise_data(_id)
      raise NotImplementedError
    end

    def handle_blending_success(result)
      raise NotImplementedError
    end

    def config
      raise NotImplementedError
    end

  end
end