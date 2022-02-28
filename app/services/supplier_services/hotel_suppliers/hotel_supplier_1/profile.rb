module SupplierServices
  module HotelSuppliers
    module HotelSupplier1
      class Profile < SupplierServices::HotelSuppliers::Profile

        after_procuring_success :register_procuring_success_callback

        # NOTE: Hard code for now
        @source_url = 'http://www.mocky.io/v2/5ebbea002e000054009f3ffc'
        # Register supplier_ref: SecureRandom.urlsafe_base64
        @supplier_ref = 'Mdmz21ip3u-EShuT7MGFKw'
        @selector_config_file = "#{Rails.root}/app/services/supplier_services/hotel_suppliers/hotel_supplier_1/selector_config.yml"

      end
    end
  end
end