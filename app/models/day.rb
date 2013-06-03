class Day < ActiveRecord::Base
  attr_accessible :date
  has_many :day_collections
  has_many :users, :through => :day_collections


  def has_user?(id)
    begin
      self.users.find(id)
    rescue
      nil
    end
  end
end
