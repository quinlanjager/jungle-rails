class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  validates :email, :first_name, :last_name, presence: true
end
