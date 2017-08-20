class EventsFacade
  def initialize(camp, user)
    @user = user
    @camp = camp
  end

  def participant
    @participant ||= Camps::BuildParticipantCommand.new(@camp, @user).execute
  end

  def participations
    @participations ||= participant.event_participations.joins(:event).
      order(Event.arel_table[:start_at]).decorate
  end

  def events
    @events ||= @camp.events
  end

  def each_event_with_participation
    events.each do |event|
      yield event, participations.find{ |p| p.event_id == event.id }
    end
  end
end
