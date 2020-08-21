class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :location, :bio, :avatar, :title, :about, :likes
  has_many :recipes
  has_many :experiances
  has_many :ratings
  has_many :likes
end
