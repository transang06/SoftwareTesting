class User < ApplicationRecord
  has_many :receipts, dependent: :destroy
  has_many :working_shift_staffs, dependent: :destroy
  has_many :receipt_details, through: :receipts
  has_many :working_shifts, through: :working_shift_staffs
  has_one_attached :avatar

  enum role: {customer: 0, admin: 1, staff: 2}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\d[0-9]\)*\z/.freeze
  attr_accessor :activation_token
  validates :first_name, presence: true,
    length: {maximum: Settings.validation.max_length_50}
  validates :last_name, presence: true,
    length: {maximum: Settings.validation.max_length_50}
  validates :phone, presence: true,
    format: {with: VALID_PHONE_REGEX}
  validates :email, presence: true,
    length: {maximum: Settings.validation.max_length_255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: true
  validates :password, presence: true, length:
    {minimum: Settings.validation.min_length_8}, allow_nil: true
  has_secure_password
  before_save{email.downcase!}
  before_create :create_activation_digest

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password?(token)
  end

  def activate
    update_column(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
