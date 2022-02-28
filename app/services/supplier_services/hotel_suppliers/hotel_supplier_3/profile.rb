module SupplierServices
  module HotelSuppliers
    module HotelSupplier3
      class Profile < SupplierServices::HotelSuppliers::Profile

        after_procuring_success :register_procuring_success_callback

        # NOTE: Hard code for now
        @source_url = 'http://www.mocky.io/v2/5ebbea1f2e00002b009f4000'
        # Register supplier_ref: SecureRandom.urlsafe_base64
        @supplier_ref = 'I4dsk7OgIZ6HpXiQsJR25Q'
        @selector_config_file = "#{Rails.root}/app/services/supplier_services/hotel_suppliers/hotel_supplier_3/selector_config.yml"

      end
    end
  end
end