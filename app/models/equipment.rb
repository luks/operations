class Equipment < ActiveRecord::Base
  attr_accessible :item_id, :key, :value

  belongs_to :item
end
