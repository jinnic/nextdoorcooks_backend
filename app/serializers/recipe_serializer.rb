class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id
  belongs_to :user
  has_many :ratings, as: :rateable
end
