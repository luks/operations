class Eventuser < ActiveRecord::Base
  attr_accessible :user_id, :event_id, :status_id
  belongs_to :user
  belongs_to :event
  belongs_to :status
end
