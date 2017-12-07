class User < ActiveRecord::Base
  has_secure_password
  validates :email, :first_name, :last_name, presence: true
end
