class User < ActiveRecord::Base
  attr_accessible :name
  has_many :eventuser
  has_many :events, :through => :eventuser, :uniq => true 
  has_one :day_collection

  def self.free_for_shift(day)
    #self.joins(:day_collection).where("day_collections.day_id = ? AND day_collections.user_id != ? ", day.id, 1)
    self.find_by_sql("SELECT users.* FROM users WHERE users.id NOT IN  ( SELECT day_collections.user_id FROM day_collections  WHERE day_collections.day_id = #{day.id} )" )
  end
end
