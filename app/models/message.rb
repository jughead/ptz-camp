class Message < ApplicationRecord
  belongs_to :user
  has_many :notifications, dependent: :destroy

  validates :user, presence: true
  validates :text, presence: true

  add_command :create_notifications
  add_command :add_sent_amount

  def processed?
    processed_at
  end

  def sent?
    processed? && sent == notifications_count
  end
end
