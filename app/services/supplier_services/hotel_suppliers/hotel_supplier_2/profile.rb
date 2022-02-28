module SupplierServices
  module HotelSuppliers
    module HotelSupplier2
      class Profile < SupplierServices::HotelSuppliers::Profile

        after_procuring_success :register_procuring_success_callback

        # NOTE: Hard code for now
        @source_url = 'http://www.mocky.io/v2/5ebbea102e000029009f3fff'
        # Register supplier_ref: SecureRandom.urlsafe_base64
        @supplier_ref = 'YkUrMLeEiW3N32VPyWm0IA'
        @selector_config_file = "#{Rails.root}/app/services/supplier_services/hotel_suppliers/hotel_supplier_2/selector_config.yml"

      end
    end
  end
end