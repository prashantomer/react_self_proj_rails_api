# == Schema Information
#
# Table name: amenities
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Amenity < ApplicationRecord
  has_many :space_amenities
  has_many :spaces, through: :space_amenities
  validates :name, uniqueness: true
end
