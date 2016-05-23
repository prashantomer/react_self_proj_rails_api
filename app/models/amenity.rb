class Amenity < ApplicationRecord
  has_many :space_amenities
  has_many :spaces, through: :space_amenities
end
