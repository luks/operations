class DayCollection < ActiveRecord::Base
  attr_accessible :shift_id, :status_id, :user_id, :day_id, :center_id
  belongs_to :user
  belongs_to :status
  belongs_to :shift
  belongs_to :day
end
