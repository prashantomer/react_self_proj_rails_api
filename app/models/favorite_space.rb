class FavoriteSpace < ApplicationRecord
  belongs_to :space
  belongs_to :user
end
