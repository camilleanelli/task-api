class Task < ApplicationRecord
  belongs_to :project

  validates :title, presence: true

  enum :status, { pending: 0, in_progress: 1, completed: 2, testing: 3, archived: 4 }
end
