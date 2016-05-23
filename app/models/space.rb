class Space < ApplicationRecord
  belongs_to :user
  belongs_to :space_type
  has_many :space_amenities
  has_many :amenities, through: :space_amenities
end
