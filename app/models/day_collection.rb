class DayCollection < ActiveRecord::Base
  attr_accessible :shift_id, :status_id, :user_id, :day_id
  belongs_to :user
  belongs_to :status
  belongs_to :shift
	

end
