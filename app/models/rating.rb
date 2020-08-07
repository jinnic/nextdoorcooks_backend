class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :rateable, :polymorphic => true

  validates :rateable, :user, {presence :true}
  validates_uniqueness_of :user_id, :scope => [:rateable_id, :rateable_type]
end
