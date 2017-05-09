class User < ApplicationRecord
  attr_encrypted :password, key: ENV["AES_KEY"]

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
end
