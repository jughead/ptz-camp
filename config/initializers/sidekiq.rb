Sidekiq.configure_server do |config|
  config.on(:startup) do
    @started_thread = Thread.new do
      TelegramBot::Runner.run
    end
  end

  config.on(:quiet) do
    @started_thread.terminate
  end

  config.on(:shutdown) do
    @started_thread.terminate
  end
end
