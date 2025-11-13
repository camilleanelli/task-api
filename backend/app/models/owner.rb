class Owner < ApplicationRecord
  belongs_to :user
  has_many :projects, dependent: :destroy

  validates :user, presence: true
end
