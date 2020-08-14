class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :description, :ingredients, :instructions
  belongs_to :user
  has_many :ratings, as: :rateable
  has_many :likes, as: :likeable  
  has_many :items, as: :imageable
end
