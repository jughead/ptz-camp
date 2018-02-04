# frozen_string_literal: true
class Notifications::NotifyCommand
  CHAT_MIGRATED_TO_SUPERGROUP = 'Bad Request: group chat was migrated to a supergroup chat'
  def initialize(notification)
    @notification = notification
  end

  def execute
    ActiveRecord::Base.transaction do
      begin
        @notification.update!(sent_at: Time.current)
        TelegramNotification.new(@notification.recipient, @notification.message).run
      rescue Telegram::Bot::Exceptions::ResponseError => e
        if e.to_s.include?(CHAT_MIGRATED_TO_SUPERGROUP)
          migrate_recipient(e.send(:data)) && retry
        else
          raise e
        end
      end
    end
  end

  private

  def migrate_recipient(data)
    new_telegram_chat_id = data.dig('parameters', 'migrate_to_chat_id')
    return unless new_telegram_chat_id
    new_recipient = TelegramGroup.find_or_initialize_by(telegram_chat_id: new_telegram_chat_id)
    new_recipient.title = @notification.recipient.title
    new_recipient.save!
    if @notification.recipient.id != new_recipient.id
      @notification.recipient.destroy!
      @notification.recipient = new_recipient
      begin
        @notification.save!
        true
      rescue ActiveRecord::RecordNotUnique
        # the notification with this recipient already exist
        false
      end
    end
  end
end
