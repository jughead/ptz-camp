class Notification < ApplicationRecord
  belongs_to :message
  belongs_to :telegram_user

  validates :message, presence: true
  validates :telegram_user, presence: true

  scope :not_sent, -> { where(sent_at: nil) }

  add_command :notify
end
