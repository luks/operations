class Booking < ActiveRecord::Base
  attr_accessible :from, :item_id, :till, :user_id
  belongs_to :item
end
