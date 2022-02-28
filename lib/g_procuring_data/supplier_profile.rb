module GProcuringData
  class SupplierProfile

    class << self

      include Callbacks

      attr_reader :source_url,
                  :supplier_ref,
                  :selector_config_file,
                  :cache_ttl

      def selector_configs
        @selector_configs ||= build_selector_config
      end

      def snapshot_model
        register_snapshot_model
      end

      def model
        register_model
      end

      def execute_blending_task
        register_blending_task.present? && register_blending_task
      end

      def cache_options
        cache_ttl.present? ? { cache_ttl: cache_ttl } : {}
      end

      protected

      def register_snapshot_model
        raise NotImplementedError
      end

      def register_model
        raise NotImplementedError
      end

      def register_procuring_error_callback
        raise NotImplementedError
      end

      def register_procuring_success_callback
        raise NotImplementedError
      end

      def register_blending_task
        nil
      end

      private

      def build_selector_config
        raise NotImplementedError if @selector_config_file.blank?

        # TODO: Check valid file here
        YAML.load_file(@selector_config_file).with_indifferent_access
      end

    end
  end
end