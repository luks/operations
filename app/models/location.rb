class Location < ActiveRecord::Base
  attr_accessible :name, :parent_id
  has_many :items

  has_ancestry

  def breadcrumb


  end
end
