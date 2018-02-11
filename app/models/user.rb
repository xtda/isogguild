class User < ApplicationRecord
  include Clearance::User

  has_secure_token
  enum access_level: [:user, :admin]
end
