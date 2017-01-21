class Telegram::BaseCommand
  attr_reader :request
  delegate :log_info, :log_warn, :log_debug, :message, :reply, :reply_text,
    to: :request

  def initialize(request)
    @request = request
  end

  def execute
    raise NotImplementedError, 'must be implemented in subclasses'
  end

  def self.call(request)
    new(request).execute
  end

end
