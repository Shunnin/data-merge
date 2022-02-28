module GBlendingData
  module Tasks
    class CreateBlendingTask

      include Sidekiq::Worker
      sidekiq_options retry: 3

      def perform(blending_worker, source_ids)
        return if blending_worker.nil? || source_ids.blank?

        worker_class = get_blending_worker_class(blending_worker)
        worker_class.new(source_ids).execute
      end

      private

      def get_blending_worker_class(klass)
        klass.is_a?(String) ? klass.constantize : klass
      end

    end
  end
end