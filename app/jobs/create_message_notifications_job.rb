class CreateMessageNotificationsJob < ApplicationJob
  queue_as :default

  def perform(message)
    return if message.processed?
    message.create_notifications
    message.processed_at = Time.current
    message.notifications_count = message.notifications.count
    message.save!
    SendMessageNotificationsJob.perform_later(message)
  end
end
