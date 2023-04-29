class AnotherClass < ActiveRecord::Base
  include ActiveRecordMask

  # Associations, validations, and other model code...
  has_many :some_classes

  # ActiveRecordMask configuration
  configure_active_record_mask do |config|
    config.show_real_data_by_default(true)
    config.allow_attributes([:id, :some_integer])
    config.allow_associations([:some_classes])
    config.revealed_defaults({ description: 'hello default' })
  end
end
