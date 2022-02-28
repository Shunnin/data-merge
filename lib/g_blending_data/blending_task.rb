module GBlendingData
  class BlendingTask

    def execute
      batch_ids = split_params

      return if batch_ids.blank?

      blending_worker_class = get_blending_worker_class
      schedule_blending_tasks(blending_worker_class, batch_ids)
    end

    protected

    def split_params
      raise NotImplementedError
    end

    private

    def schedule_blending_tasks(blending_worker_class, batch_ids)
      batch_ids.each do |source_ids|
        Tasks::CreateBlendingTask.perform_async(blending_worker_class, source_ids)
      end
    end

    def get_blending_worker_class
      klass = self.class.module_parent.const_get(:BlendingWorker)

      raise StandardError, 'Missing register BlendingWorker!!!' if klass.nil?

      klass
    end

  end
end