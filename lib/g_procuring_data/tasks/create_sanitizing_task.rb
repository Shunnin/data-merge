module GProcuringData
  module Tasks
    class CreateSanitizingTask

      include Sidekiq::Worker
      sidekiq_options retry: 3,
                      lock: :while_executing,
                      lock_args: ->(args) { [args[0]] },
                      on_conflict: :reject

      def perform(url, profile)
        return if url.nil? || profile.nil?

        profile_class = get_profile_class(profile)

        mark_procuring_task_to_state(profile_class, ProcuringTask.states[:in_progress])

        result = GProcuringData::Sanitizing.new(profile_class).execute

        if result[:success]
          source_type = profile_class.snapshot_model.to_s

          mark_procuring_task_to_state(profile_class, ProcuringTask.states[:done])
          PostProcuringDoneTask.perform_async(source_type, profile_class)
        end
      end

      private

      def get_profile_class(profile)
        profile.is_a?(String) ? profile.constantize : profile
      end

      def mark_procuring_task_to_state(profile, state)
        ProcuringTask.find_by(
          source_type: profile.snapshot_model.to_s,
          source_ref:  profile.supplier_ref,
        ).update!(state: state)
      end

    end
  end
end