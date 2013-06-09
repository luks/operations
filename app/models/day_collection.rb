class DayCollection < ActiveRecord::Base
  attr_accessible :shift_id, :status_id, :user_id, :day_id, :center_id
  belongs_to :user
  belongs_to :status
  belongs_to :shift
  belongs_to :day
  belongs_to :datacenter, :foreign_key => :center_id



  
  def self.optimalised(from, to)
    self.find_by_sql("SELECT day_collections.* FROM day_collections 
                      LEFT JOIN days ON day_collections.day_id = days.id 
                      WHERE  (days.date BETWEEN '#{from}' AND '#{to}')")
  end     	        

#  def send_confirmation_email
#    if(self.status_id == 1) 
#       Notifier.day_confirm(self.user.email) 
#    end  
#  end  

end
