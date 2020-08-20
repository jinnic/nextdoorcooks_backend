class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration, :cuisines, :description, :ingredients, :instructions, :date
  belongs_to :user
  has_many :ratings, as: :rateable
  has_many :likes, as: :likeable  
  has_many :items, as: :imageable

  def date
    self.object.created_at.to_date.to_formatted_s(:long_ordinal)
  end
end
