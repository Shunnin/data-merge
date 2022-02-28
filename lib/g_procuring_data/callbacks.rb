module GProcuringData
  module Callbacks

    def after_procuring_success(callback_method)
      if @after_procuring_success_callbacks.blank?
        @after_procuring_success_callbacks = [callback_method]
      else
        @after_procuring_success_callbacks << callback_method
      end
    end

    def after_procuring_error(callback_method)
      if @after_procuring_error_callbacks.blank?
        @after_procuring_error_callbacks = [callback_method]
      else
        @after_procuring_error_callbacks << callback_method
      end
    end

    def after_procuring_success_callbacks
      @after_procuring_success_callbacks ||= []
    end

    def after_procuring_error_callbacks
      @after_procuring_error_callbacks ||= []
    end

  end
end