class Datacenter < ActiveRecord::Base
  attr_accessible :name
  has_many :days
end
