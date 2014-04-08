class Accessory < ActiveRecord::Base
  attr_accessible :item_id, :key, :value, :label
  belongs_to :item
end
