class EventParticipationDecorator < ApplicationDecorator
  def status
    if goes?
      "You are in!"
    else
      "You're not going to the event."
    end
  end
end
