class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :role
  has_many :eventuser
  has_many :events, :through => :eventuser, :uniq => true 
  has_one :day_collection

  ROLES = %w[admin operator]

  def self.free_for_shift(day)
    #self.joins(:day_collection).where("day_collections.day_id = ? AND day_collections.user_id != ? ", day.id, 1)
    self.find_by_sql("SELECT users.* FROM users WHERE users.id NOT IN  ( SELECT day_collections.user_id FROM day_collections  WHERE day_collections.day_id = #{day.id} )" )
  end

  def admin?
    self.role == 'admin'
  end

end
