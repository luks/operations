class Day < ActiveRecord::Base
  attr_accessible :date, :center_id
  has_many :day_collections
  has_many :users, :through => :day_collections
  belongs_to :datacenter

  def has_user?(id)
    begin
      self.users.find(id)
    rescue
      nil
    end
  end
end
