class User < ApplicationRecord
  attr_encrypted :password, key: ENV["AES_KEY"]

  validates :username, presence: true
  validates :password, presence: true
end
