class HashUtil
  class << self

    DELIMITER = '.'.freeze
    REGEXP = %r{[\]\[\.]}.freeze

    def flatten_hash(hash_value, key_names = [])
      case hash_value
      when Array
        hash_value.each_with_index.with_object({}) do |(value, index), result|
          result.merge!(flatten_hash(value, key_names + ["[#{index}]"]))
        end
      when Hash
        hash_value.each_with_object({}) do |(key, value), result|
          result.merge!(flatten_hash(value, key_names + [key]))
        end
      else
        { key_names.join(DELIMITER) => hash_value }
      end
    end

    def get(hash, path, type: nil, default: nil, hash_mapping: {})
      return default if path.blank?

      parts = if path.is_a?(String)
                path.split(REGEXP).reject(&:blank?)
              else
                Array(path)
              end

      value = parts.reduce(hash) do |acc, key|
        if acc.is_a?(Hash)
          acc[key.to_s] || acc[key.to_sym]
        elsif acc.is_a?(Array)
          acc[key.to_i]
        end
      end

      return build_default_value(type, default) if value.nil?

      convert_value(value, type, hash_mapping)
    end

    private

    def build_default_value(type, default)
      return default if default.present? || type.blank?

      case type
      when :string
        ''
      when :hash
        { }
      when :array
        []
      else
        default
      end
    end

    def convert_value(value, type, hash_mapping)
      return value if type.nil?

      case type
      when :string
        value.to_s
      when :hash
        mapping_hash(value, hash_mapping)
      when :array
        mapping_array_hash(value, hash_mapping)
      end
    end

    def mapping_hash(hash, mapping_config)
      return hash if mapping_config.blank? || !hash.is_a?(Hash)

      mapping_config.reduce({}) do |acc, (org_key, mapping_key)|
        acc.merge!(mapping_key => hash[org_key])
      end
    end

    def mapping_array_hash(array, mapping_config)
      return Array(array) if mapping_config.blank?

      array.map { |hash| mapping_hash(hash, mapping_config) }
    end

  end
end