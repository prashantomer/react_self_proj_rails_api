class SpaceImage < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :space
end
