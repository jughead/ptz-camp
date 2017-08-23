class EventsController < ApplicationController
  load_camp_parent
  load_and_authorize_resource
  decorate_current_camp

  def index
    @facade = EventsFacade.new(current_user, @camp)
    render_html_json 'events/list', facade: @facade
  end

  def opt_in
    @facade = EventFacade.new(current_user, @camp, @event)
    @participation = @facade.participation
    @participation.state = :goes
    render json: {success: @participation.save}
  end

  def opt_out
    @facade = EventFacade.new(current_user, @camp, @event)
    @participation = @facade.participation
    @participation.state = :skips
    render json: {success: @participation.save}
  end

  def show
    @facade = EventFacade.new(current_user, @camp, @event)
    respond_to do |format|
      format.html
      format.json do
        render_html_json 'events/status', event: @facade.event,
          participation: @facade.participation
      end
    end
  end

  def participants
    @facade = EventFacade.new(current_user, @camp, @event)
    render_html_json 'events/participants', facade: @facade
  end

  private

  def render_html_for_json(partial, locals={})
    render_to_string partial: partial, formats: :html, locals: locals
  end

  def render_html_json(partial, locals={})
    render json: {html: render_html_for_json(partial, locals) }.to_json
  end
end
