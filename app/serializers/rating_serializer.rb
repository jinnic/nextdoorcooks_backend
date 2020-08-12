class RatingSerializer < ActiveModel::Serializer
  attributes :id, :stars, :comment, :user_id, :rateable_type, :rateable_id
  # belongs_to :user
  # belongs_to :likeable, :polymorphic => true

  def rateable_id
    if self.object.rateable
      self.object.rateable.id
    end
  end
end
