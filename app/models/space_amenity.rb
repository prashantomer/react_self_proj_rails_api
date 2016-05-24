# == Schema Information
#
# Table name: space_amenities
#
#  id         :integer          not null, primary key
#  space_id   :integer
#  amenity_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SpaceAmenity < ApplicationRecord
  belongs_to :amenity
  belongs_to :space
end
