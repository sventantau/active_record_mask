class SomeClass < ActiveRecord::Base
  include ActiveRecordMask

  has_many :another_classes
  
  # ActiveRecordMask configuration
  configure_active_record_mask do |config|
    config.show_real_data_by_default(false)
    config.allow_attributes([:id])
    # config.allow_associations([:another_classes])
    config.revealed_defaults({ title: 'hidden' })
  end

  # we do not touch any other methods than the 'db related' ones
  def some_method
    "no change here!"
  end

end