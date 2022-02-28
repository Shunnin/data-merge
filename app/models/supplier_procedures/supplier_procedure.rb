# This table use for snapshot after procuring raw data from Supplier
class SupplierProcedure < ApplicationRecord

  enum state: {
    # noise: Not process sanitizing data yet
    noise: 0,
    # noise: Already blended and process sanitizing
    clean: 1,
  }.freeze

  serialize :value, JSON

end