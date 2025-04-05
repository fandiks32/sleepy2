class User < ApplicationRecord
  has_many :followings, class_name: 'Follow', foreign_key: 'followed_id'
  has_many :followers, class_name: 'Follow', foreign_key: 'follower_id'
end
