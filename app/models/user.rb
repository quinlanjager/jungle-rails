class User < ActiveRecord::Base
  has_secure_password
  before_create :downcase_email

  has_many :orders
  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: true
  validate :check_password_length

  def self.authenticate_with_credentials(email, password)
    email = email.rstrip.downcase
    user = User.find_by(email: email)
    if user and user.authenticate password
      return user
    end
    nil
  end

  private

    def downcase_email
      self.email = self.email.downcase
    end

    def check_password_length
      if self.password.present? and self.password.length < 8
        errors.add(:password, "can't be less than 8 characters")
      end
    end

end
