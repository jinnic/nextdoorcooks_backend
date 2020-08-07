class ExperianceSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_id
  belongs_to :user
  has_many :ratings, as: :rateable
end
