module GProcuringData
  class Sanitizing

    def initialize(profile)
      @profile = profile
    end

    def execute
      return if @profile.blank?

      supplier_data = build_supplier_data
      # NOTE: Before process sanitizing, we can build the mechanism to
      # validate selector_config_file is invalid or not
      supplier_data.each(&method(:process_sanitizing))

      { success: true }
    end

    private

    def build_supplier_data
      request = Typhoeus.get(@profile.source_url, @profile.cache_options)

      raise StandardError, 'Can not read!' if request.code != 200

      MultiJson.load(request.body)
    end

    def build_configs
      @build_configs ||= @profile.selector_configs
    end

    def process_sanitizing(value)
      result = {}

      build_configs.each do |key, config|
        key_mapping = config[:key]

        if key_mapping.present?
          selected_value = sanitize_raw_data(config, key_mapping, value)
          result[key.to_sym] = selected_value if selected_value.present?
        end
      end

      if result.present? && result[:id].present?
        @profile.after_procuring_success_callbacks.each do |cb|
          @profile.send(cb, result)
        end
      else
        @profile.after_procuring_error_callbacks.each do |cb|
          @profile.send(cb)
        end
      end
    end

    def sanitize_raw_data(config, key_mapping, value)
      type = config[:type]
      hash_mapping = config[:hash_mapping] || { }

      HashUtil.get(
        value,
        key_mapping,
        type:         type,
        hash_mapping: hash_mapping
      )
    end

  end
end