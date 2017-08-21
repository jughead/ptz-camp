class Admin::EventsController < Admin::ApplicationController
  load_resource :camp
  load_and_authorize_resource through: :camp

  decorate_current_camp
  before_action :decorate
  before_action :load_events, only: [:new, :edit, :update, :create]

  def index
    @events = @events.decorate
  end

  def new
  end

  def edit
  end

  def update
    if @event.update(update_params)
      redirect_to({action: :index}, notice: 'The event is updated')
    else
      render :new
    end
  end

  def create
    if @event.save
      redirect_to({action: :index}, notice: 'The event is added')
    else
      render :new
    end
  end

  def destroy
    @event.destroy
    redirect_to({action: :index}, notice: 'The event is deleted')
  end

  def show
  end

  private

    def params_keys
      [:name, :description, :start_at, :position, restricted_event_ids: []]
    end

    def create_params
      params.require(:event).permit(*params_keys)
    end

    def update_params
      params.require(:event).permit(*params_keys)
    end

    def decorator_class
      Admin::EventDecorator
    end

    def decorate
      @event &&= decorator_class.decorate(@event)
    end

    def load_events
      @events = @camp.events.where.not(id: @event.id)
    end
end
