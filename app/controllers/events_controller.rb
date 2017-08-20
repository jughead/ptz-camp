class EventsController < ApplicationController
  load_camp_parent
  load_and_authorize_resource
  decorate_current_camp

  def opt_in
    find_or_build_participation
    @participation.state = :goes
    render json: {success: @participation.save, html: render_status}
  end

  def opt_out
    find_or_build_participation
    @participation.state = :skips
    render json: {success: @participation.save, html: render_status}
  end

  def show
    @participants = @camp.participants.joins(:event_participations).
      includes(:delegation).
      merge(EventParticipation.goes.where(event_id: @event.id)).
      ordered_by_delegation.ordered_by_name.decorate
    @event = @event.decorate
  end

  private

  def find_or_build_participation
    @facade = EventsFacade.new(@camp, current_user)
    @participation = @event.participations.find_or_initialize_by(
      participant: @facade.participant
    )
    @participation = @participation.decorate
  end

  def render_status
    render_to_string partial: 'events/list', locals: {
      facade: @facade
    }
  end
end
