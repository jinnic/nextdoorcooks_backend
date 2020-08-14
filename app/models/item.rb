class Item < ApplicationRecord
  belongs_to :user
  belongs_to :imageable, :polymorphic => true

  validates :imageable, :user, {presence: :true}
  # validates_uniqueness_of :user_id, :scope => [:imageable_id, :imageable_type]
end
