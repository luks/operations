class Image < ActiveRecord::Base
  attr_accessible :description, :item_id, :name,:image, :image_cache
   mount_uploader :image, ImageUploader
   belongs_to :item
end
