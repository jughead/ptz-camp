# frozen_string_literal: true
require 'telegram/bot'
module TelegramBot
  class Request < Struct.new(:runner, :request_message)
    def reply_text(message)
      reply(text: message)
    end

    def reply(message)
      runner.reply(request_message, message)
    end

    delegate :log_info, :log_debug, :log_warn, to: :runner
  end

  class Runner
    include Singleton

    def self.run
      self.instance.run
    end

    def self.on(message, &block)
      self.instance.on(message, &block)
    end

    def initialize
      config = Rails.application.config.secrets
      @token = config.telegram_bot_api_token
      @routes = Hash.new
      @logger = Rails.logger
    end

    def run
      Telegram::Bot::Client.run(@token) do |bot|
        @bot = bot
        bot.listen do |message|
          route_message(message)
        end
      end
      @bot = nil
    end

    def reply(initial_message, answer)
      chat_id = initial_message.chat.id
      @bot.api.send_message(chat_id: chat_id, **answer)
    end

    def on(message, &block)
      @routes[message] = block
    end

    private

      def route_message(message)
        log_info "Got message: #{message.truncate(length: 30)}"
        if @routes.has_key?(message)
          @routes[message].call(Request.new(self, message))
        else
          log_warn "Cannot route the message: #{message.truncate(length: 30)}"
        end
      end

      def log_info(message)
        log(:info, message)
      end

      def log_debug(message)
        log(:debug, message)
      end

      def log_warn(message)
        log(:warn, message)
      end

      def log(level, message)
        return unless @logger
        @logger.tagged('TelegramBot') do
          @logger.public_send(level, message)
        end
      end
  end
end
