class User < ActiveRecord::Base
  has_many :articles
  has_many :comments

  validates :email, uniqueness: true

  has_secure_password
end
