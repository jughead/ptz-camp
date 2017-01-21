TelegramBot::Runner.tap do |routes|
  # The second value is either a callable object or a Symbol with the name of
  # Telegram command. It will try to find the Telegram::{symbol}Command class
  routes.on '/start', :start
end
