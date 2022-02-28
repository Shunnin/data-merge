module SupplierServices
  module HotelSuppliers
    class Profile < ::GProcuringData::SupplierProfile

      class << self

        protected

        def register_snapshot_model
          HotelSupplierProcedure
        end

        def register_model
          Hotel
        end

        def register_blending_task
          MergingServices::Hotel::BlendingTask.new.execute
        end

        def register_procuring_success_callback(result)
          ActiveRecord::Base.transaction do
            snapshot_model.create_or_update!(
              {
                source_id:    result[:id],
                supplier_ref: supplier_ref,
              }, {
                source_id:    result[:id],
                supplier_ref: supplier_ref,
                value:        result,
                state:        snapshot_model.states[:noise],
              }
            )
          end
        rescue => e
          # Error handler
        end

        def register_procuring_error_callback
          # Handle when procuring error here
        end

      end
    end
  end
end