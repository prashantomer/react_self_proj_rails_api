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
  before_destroy :check_for_spaces
  has_many :spaces
  validates :name, uniqueness: true, presence: true

  private

  def check_for_spaces
    if spaces.any?
      errors.add_to_base('cannot delete space types with associated spaces')
      return false
    end
  end
end
