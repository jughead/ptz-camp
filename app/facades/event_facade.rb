class EventFacade
  def initialize(user, camp, event)
    @user = user
    @camp = camp
    @event = event
  end

  def participants
    @participants ||= @camp.participants.joins(:event_participations).
      includes(:delegation).
      merge(EventParticipation.goes.where(event_id: @event.id)).
      ordered_by_delegation.ordered_by_name.decorate
  end

  def event
    @event_decorated ||= @event.decorate
  end

  def participation
    @participation ||= @event.participations.find_or_initialize_by(
      participant: participant
    ).decorate
  end

  def participant
    @participant ||= Camps::BuildParticipantCommand.new(@camp, @user).execute
  end
end
