class FavoriteSpaceSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :space
  belongs_to :user
end
