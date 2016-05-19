class Space < ApplicationRecord
  belongs_to :user
  belongs_to :space_type

  has_and_belongs_to_many :amenities


end
