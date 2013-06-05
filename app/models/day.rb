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


  def self.day_collection_optimalised(from, to)
    self.find_by_sql("SELECT days.date, days.center_id,  users.name AS user, shifts.shift, statuses.name AS status  FROM days 
                      LEFT JOIN day_collections ON days.id = day_collections.day_id
                      LEFT JOIN users ON users.id = day_collections.user_id
                      LEFT JOIN shifts ON shifts.id = day_collections.shift_id 
                      LEFT JOIN statuses ON statuses.id = day_collections.status_id 
                      WHERE  (days.date BETWEEN '#{from}' AND '#{to}')")
                      #days.center_id = '#{center_id}' AND
  end

end
