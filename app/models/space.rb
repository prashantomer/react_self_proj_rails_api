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

class Space < ApplicationRecord
  belongs_to :user
  belongs_to :space_type
  has_many :space_amenities, dependent: :destroy
  has_many :amenities, through: :space_amenities
  validates :user_id, :space_type_id, :title, :address_line_1,
            :city, :country, :latitude, :longitude, presence: true
end
