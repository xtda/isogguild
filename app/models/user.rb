class User < ApplicationRecord
  include Clearance::User

  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_secure_token
  enum access_level: [:user, :officer, :admin]
end
