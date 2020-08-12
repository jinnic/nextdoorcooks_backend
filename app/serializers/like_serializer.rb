class LikeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :likeable_type, :likeable_id
  # belongs_to :user
  # belongs_to :likeable, :polymorphic => true

  def likeable_id
    if self.object.likeable
      self.object.likeable.id
    end
  end
end
