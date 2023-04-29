class MoreClass < ActiveRecord::Base
  include ActiveRecordMask
  has_many :some_classes
end