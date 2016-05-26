# == Schema Information
#
# Table name: spaces
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  space_type_id  :integer
#  title          :string
#  slug           :string
#  description    :text
#  address_line_1 :string
#  address_line_2 :string
#  city           :string
#  state          :string
#  country        :string
#  latitude       :string
#  longitude      :string
#  capacity       :decimal(, )
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

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
  has_many    :space_images
  belongs_to  :user
  belongs_to  :space_type

  cache expires_in: 1.minute
end
