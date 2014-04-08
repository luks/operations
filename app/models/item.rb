class Item < ActiveRecord::Base
  attr_accessible :desc, :location_id, :media_id, :name, :short_desc, :type_id, :image, 
  :image_cache, :title, :parent_id, :capacity
  has_ancestry
  belongs_to :location
  mount_uploader :image, ImageUploader
  has_many :images
  has_many :accessories
  has_many :bookings
  has_many :equipments
end
