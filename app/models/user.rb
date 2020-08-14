class User < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: { case_sensitive: false }
  has_many :recipes, dependent: :destroy
  has_many :experiances, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :items, dependent: :destroy
  
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users
end
