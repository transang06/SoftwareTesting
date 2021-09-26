class Receipt < ApplicationRecord
  belongs_to :user
  belongs_to :room

  enum status: {wait: 0, approved: 1, complete: 2,
                cancelled_by_admin: 3, cancelled_by_you: 4}
  scope :status_priority, ->{order :status}
  scope :latest, ->{order created_at: :desc}
end
