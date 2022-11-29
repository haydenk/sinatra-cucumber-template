class User < ApplicationRecord
  has_secure_password

  include UUID
  validates :username, uniqueness: true
end
