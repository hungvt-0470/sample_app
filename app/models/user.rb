class User < ApplicationRecord
  USER_PARAMS = [
    :name,
    :email,
    :password,
    :password_confirmation
  ].freeze

  before_save :downcase_email

  validates :name, presence: true,
            length: {maximum: Settings.users.name_max_length}
  validates :email, presence: true,
            length: {maximum: Settings.users.email_max_length},
            format: {with: Regexp.new(Settings.users.email_validate_regex,
                                      Regexp::IGNORECASE)},
            uniqueness: true

  has_secure_password

  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create string, cost:
  end

  private

  def downcase_email
    email.downcase!
  end
end
