class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.create_or_update!(conditions, attributes)
    record = find_or_initialize_by(conditions)

    record.assign_attributes(attributes)
    record.save!

    record
  end
end
