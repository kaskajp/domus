class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, :last_name, presence: true
  validates :role, inclusion: { in: %w[admin user] }

  before_validation :set_default_role, on: :create
  before_save :normalize_email

  scope :admins, -> { where(role: "admin") }
  scope :confirmed, -> { where.not(confirmed_at: nil) }
  scope :unconfirmed, -> { where(confirmed_at: nil) }

  def admin?
    role == "admin"
  end

  def confirmed?
    confirmed_at.present?
  end

  def confirm!
    update!(confirmed_at: Time.current)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def set_default_role
    self.role ||= "user"
  end

  def normalize_email
    self.email = email.downcase.strip if email.present?
  end
end
