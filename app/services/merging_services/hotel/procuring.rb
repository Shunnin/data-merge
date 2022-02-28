module MergingServices
  module Hotel
    class Procuring < GProcuringData::Procuring

      protected

      def register_supplier_profile
        GProcuringData::Setting.config do |conf|
          conf.register_profile([
            SupplierServices::HotelSuppliers::HotelSupplier1::Profile,
            SupplierServices::HotelSuppliers::HotelSupplier2::Profile,
            SupplierServices::HotelSuppliers::HotelSupplier3::Profile,
          ])
        end
      end

    end
  end
end