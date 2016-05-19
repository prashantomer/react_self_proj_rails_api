class AmenitySerializer < ActiveModel::Serializer
  attributes  :id,
              :name

  cache expires_in: 1.day
end
