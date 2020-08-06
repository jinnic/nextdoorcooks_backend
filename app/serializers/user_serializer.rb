class UserSerializer < ActiveModel::Serializer
  attributes :username, :location, :bio, :avatar
end
