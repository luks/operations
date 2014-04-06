class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :role

  has_one :day_collection

  ROLES = %w[admin operator]

  def self.free_for_shift(day)
    self.find_by_sql("SELECT users.* FROM users WHERE users.id NOT IN
    ( SELECT day_collections.user_id FROM days LEFT JOIN day_collections
  ON day_collections.day_id = days.id WHERE days.date = '#{day.date}' AND day_collections.user_id IS NOT NULL) AND users.role IS NOT 'admin'")
  end


  def admin?
    self.role == 'admin'
  end

  def self.admin
    self.where(:role => "admin").first
  end   

end
