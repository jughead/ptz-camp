class TelegramUser < ApplicationRecord
	validates_presence_of :telegram_chat_id, :first_name
end
