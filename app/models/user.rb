class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, :last_name, presence: true
  validates :role, inclusion: { in: %w[admin user] }
  validates :theme, inclusion: { in: %w[light dark] }
  validate :avatar_validation

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

  def initials
    "#{first_name[0]}#{last_name[0]}".upcase
  end

  def avatar_url(size: :small)
    return nil unless avatar.attached?

    case size
    when :small
      avatar.variant(resize_to_fill: [ 40, 40 ])
    when :medium
      avatar.variant(resize_to_fill: [ 80, 80 ])
    when :large
      avatar.variant(resize_to_fill: [ 120, 120 ])
    else
      avatar
    end
  end

  private

  def set_default_role
    self.role ||= "user"
  end

  def normalize_email
    self.email = email.downcase.strip if email.present?
  end

  def avatar_validation
    return unless avatar.attached?

    if avatar.blob.byte_size > 5.megabytes
      errors.add(:avatar, "must be less than 5MB")
    end

    unless avatar.blob.content_type.in?(%w[image/jpeg image/png image/gif image/webp])
      errors.add(:avatar, "must be a JPEG, PNG, GIF, or WebP image")
    end
  end
end
