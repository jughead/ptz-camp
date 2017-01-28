class Messages::AddSentAmountCommand
  def initialize(message, amount)
    @message = message
    @amount = amount
  end

  def execute
    return if @amount == 0
    ActiveRecord::Base.transaction do
      @message.lock!
      @message.update(sent: @message.sent + @amount)
    end
  end
end
