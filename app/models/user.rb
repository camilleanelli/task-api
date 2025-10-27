class User < ApplicationRecord
  has_many :owned_projects, through: :owner, source: :projects
  has_one :owner


  validates :name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                   uniqueness: { case_sensitive: false },
                   format: { with: URI::MailTo::EMAIL_REGEXP }
end
