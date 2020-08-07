class UserSerializer < ActiveModel::Serializer
  attributes :username, :location, :bio, :avatar
  has_many :recipes
  has_many :experiances
  has_many :ratings
end
