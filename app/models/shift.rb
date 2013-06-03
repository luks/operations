class Shift < ActiveRecord::Base
  attr_accessible :name, :shift
  has_one :day_collection
end
