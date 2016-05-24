# == Schema Information
#
# Table name: amenities
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AmenitySerializer < ActiveModel::Serializer
  attributes  :id,
              :name

  cache expires_in: 1.day
end
