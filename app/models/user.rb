class User < ApplicationRecord
  attr_accessor :remember_token

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
                                      Regexp::IGNORECASE)}
  validates :password, presence: true,
            length: {minimum: Settings.users.password_min_length},
            allow_nil: true

  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost:
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_column :remember_digest, nil
  end

  private

  def downcase_email
    email.downcase!
  end
end
