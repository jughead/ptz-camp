class Notification < ApplicationRecord
  belongs_to :message
  belongs_to :recipient, polymorphic: true

  validates :message, presence: true

  scope :not_sent, -> { where(sent_at: nil) }

  add_command :notify
end
