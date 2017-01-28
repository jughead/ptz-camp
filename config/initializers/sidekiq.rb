Sidekiq.configure_server do |config|
  config.on(:startup) do
    Thread.new do
      TelegramBot::Runner.run
    end
  end
end
