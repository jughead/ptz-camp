# frozen_string_literal: true
require 'telegram/bot'
module TelegramBot
  class Request < Struct.new(:runner, :message)
    def reply_text(message)
      reply(text: message)
    end

    def reply(data)
      runner.reply(message, data)
    end

    delegate :log_info, :log_debug, :log_warn, to: :runner
  end

  class Runner
    include Singleton

    def self.run
      self.instance.run
    end

    def self.on(message, *args)
      if block_given?
        self.instance.on(message, Proc.new)
      else
        self.instance.on(message, args.first)
      end
      self
    end

    attr_accessor :logger

    def initialize
      config = Rails.application.secrets
      @token = config.telegram_bot_api_token
      @routes = Hash.new
      @logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
    end

    def load_routes
      log_info 'Loading telegram routes'
      load "#{Rails.root}/config/telegram_routes.rb"
    end

    def run
      log_info 'Starting Telegram bot API'
      load_routes
      Telegram::Bot::Client.run(@token, logger: @logger) do |bot|
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

    def log_info(message)
      log(:info, message)
    end

    def log_debug(message)
      log(:debug, message)
    end

    def log_warn(message)
      log(:warn, message)
    end

    def on(message, cb)
      @routes[message] = cb
    end

    private

      def route_message(message)
        text = message.text
        unless @routes.has_key?(text)
          log_warn "Cannot route the message: #{text.truncate(30)}"
          return
        end

        cb = @routes[text]
        cb = if cb.is_a?(Symbol)
          "Telegram::#{cb.to_s.classify}Command".constantize
        else
          cb
        end

        cb.call(Request.new(self, message))
      end

      def log(level, message)
        return unless @logger
        @logger.tagged('TelegramBot') do
          @logger.public_send(level, message)
        end
      end
  end
end
