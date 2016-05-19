class SpaceSerializer < ActiveModel::Serializer
  attributes  :id,
              :title,
              :slug,
              :description,
              :address_line_1,
              :address_line_2,
              :city,
              :state,
              :country,
              :latitude,
              :longitude,
              :capacity

  has_many    :amenities
  belongs_to  :user
  belongs_to  :space_type

  cache expires_in: 1.minute
end
