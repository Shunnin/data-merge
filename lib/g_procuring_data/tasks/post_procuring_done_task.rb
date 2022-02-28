module GProcuringData
  module Tasks
    class PostProcuringDoneTask

      include Sidekiq::Worker
      sidekiq_options retry: 3,
                      lock: :while_executing,
                      lock_args: ->(args) { [args[0]] },
                      on_conflict: :reschedule

      def perform(source_type, profile)
        return if unable_perform_blending?(source_type) || profile.nil?

        profile_class = get_profile_class(profile)

        profile_class.execute_blending_task
        ProcuringTask.where(source_type: source_type).delete_all
      end

      private

      def get_profile_class(profile)
        profile.is_a?(String) ? profile.constantize : profile
      end

      def unable_perform_blending?(source_type)
        ProcuringTask.
          where(source_type: source_type).
          where.not(state: ProcuringTask.states[:done]).
          exists?
      end

    end
  end
end