module GProcuringData
  module Setting

    @supplier_profiles ||= []

    class << self
      attr_reader :supplier_profiles

      def config
        yield self
      end

      def register_profile(profiles)
        if profiles.is_a?(Array)
          @supplier_profiles = profiles
        else
          @supplier_profiles << profiles
        end
      end

    end

  end
end