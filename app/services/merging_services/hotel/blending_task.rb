module MergingServices
  module Hotel
    class BlendingTask < GBlendingData::BlendingTask

      def split_params
        source_ids = HotelSupplierProcedure.
          where(state: SupplierProcedure.states[:noise]).
          pluck(:source_id).
          uniq

        # Hard code the slice batch number is 1 for testing purpose
        source_ids.each_slice(1).map { |ids| ids }
      end

    end
  end
end
