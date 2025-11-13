class User < ApplicationRecord
  has_secure_password

  has_many :owned_projects, through: :owner, source: :projects
  has_one :owner

  validates :email, presence: true,
                   uniqueness: { case_sensitive: false },
                   format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  after_create :ensure_or_create_owner

  def ensure_or_create_owner
    Owner.find_or_create_by(user: self)
  end

  def entire_name
    "#{name} #{last_name}"
  end
end
