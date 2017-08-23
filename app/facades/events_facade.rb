class EventsFacade
  def initialize(user, camp)
    @user = user
    @camp = camp
  end

  def participant
    @participant ||= Camps::BuildParticipantCommand.new(@camp, @user).execute
  end

  def participations
    @participations ||= participant.event_participations.decorate
  end

  def events
    @events ||= @camp.events.order(:position, :start_at)
  end

  def each_event_with_participation
    events.each do |event|
      yield event, participations.find{ |p| p.event_id == event.id }
    end
  end
end
