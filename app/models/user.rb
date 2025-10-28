class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # # Include default devise modules. Others available are:
  # # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :owned_projects, through: :owner, source: :projects
  has_one :owner


  validates :name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                   uniqueness: { case_sensitive: false },
                   format: { with: URI::MailTo::EMAIL_REGEXP }

  after_create :ensure_or_create_owner

  private

  def ensure_or_create_owner
    Owner.find_or_create_by(user: self)
  end
end
