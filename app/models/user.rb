class User < ActiveRecord::Base
  attr_accessible :name
  has_many :eventuser
  has_many :events, :through => :eventuser, :uniq => true 
  has_one :day_collection     
end
