class Status < ActiveRecord::Base
  attr_accessible :name, :title
  belongs_to :user, :foreign_key => "status_id"
  has_one :day_collection

end
