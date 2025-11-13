class Project < ApplicationRecord
  belongs_to :owner
  has_many :tasks, dependent: :destroy
  has_one :user, through: :owner

  validates :title, presence: true
  validates :owner, presence: true
end
