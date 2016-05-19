class UserSerializer < ActiveModel::Serializer
  attributes  :id,
              :name,
              :email,
              :date_of_birth,
              :phone_number,
              :is_admin

  has_many    :spaces
end
