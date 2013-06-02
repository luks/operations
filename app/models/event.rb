class Event < ActiveRecord::Base
  attr_accessible :date, :name
  has_many :eventusers
  has_many :users, :through => :eventusers, :uniq => true
  
end
