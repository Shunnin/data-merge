module GProcuringData
  class Procuring

    def initialize
      @setting ||= register_supplier_profile
    end

    def execute
      @setting.each do |profile|
        ProcuringTask.create!(
          source_ref:  profile.supplier_ref,
          source_type: profile.snapshot_model.to_s,
          state:       ProcuringTask.states[:initial]
        )

        Tasks::CreateSanitizingTask.perform_async(profile.source_url, profile)
      end
    end

    protected

    def register_supplier_profile
      raise NotImplementedError
    end

  end
end