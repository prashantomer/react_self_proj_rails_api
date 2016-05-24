# == Schema Information
#
# Table name: space_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SpaceType < ApplicationRecord
  has_many :spaces
  validates :name, uniqueness: true
end
