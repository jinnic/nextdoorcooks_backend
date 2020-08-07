class Experiance < ApplicationRecord
  belongs_to :user
  has_many :ratings, as: :rateable
end
