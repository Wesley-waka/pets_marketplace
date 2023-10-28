class User < ApplicationRecord
  attr_accessor :activation_token, :confirmed_at

  # Revocation of tokens
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable, :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :ads, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :ad_reviews, dependent: :destroy
  has_many :favourite_ads, dependent: :destroy
  has_many :messages
  # Callback to create user profile
  after_create :user_profile_creation

  def authenticate(user_email, password)
    user = User.find_for_authentication(email: user_email)
    user.valid_password?(password) ? user : false
  end

  def generate_password_token!(user)
    _raw, enc = Devise.token_generator.generate(self.class, :reset_password_token)
    user.update(
      reset_password_token: enc,
      reset_password_sent_at: Time.now.utc,
      password_token_valid: true
    )
  end

  def reset_password!(updated_password, user)
    return true if user.update(password: updated_password, reset_password_token: nil, password_token_valid: false)
  end

  def user_profile_creation
    self.create_profile()
  end
end
