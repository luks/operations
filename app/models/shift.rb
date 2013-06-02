class Shift < ActiveRecord::Base
  attr_accessible :name
  has_one :day_collection
end
