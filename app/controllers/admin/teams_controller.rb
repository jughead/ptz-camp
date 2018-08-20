class Admin::TeamsController < Admin::ApplicationController
  load_resource :camp
  load_and_authorize_resource through: :camp

  decorate_current_camp
  before_action :decorate

  def index
    @teams = @teams.includes(:participants, :delegation)
    @teams = Admin::TeamDecorator.decorate_collection(@teams.decorate)
  end

  def new
  end

  def edit
  end

  def update
    if @team.update(update_params)
      redirect_to({action: :index}, notice: 'The team is updated')
    else
      render :new
    end
  end

  def create
    if @team.save
      redirect_to({action: :index}, notice: 'The team is added')
    else
      render :new
    end
  end

  def destroy
    @team.destroy
    redirect_to({action: :index}, notice: 'The team is deleted')
  end

  def show
  end

  private

    def params_keys
      [:name, :with_laptop, :delegation_id, participant_ids: []]
    end

    def create_params
      params.require(:team).permit(*params_keys)
    end

    def update_params
      params.require(:team).permit(*params_keys)
    end

    def decorator_class
      Admin::TeamDecorator
    end

    def decorate
      @team &&= decorator_class.decorate(@team)
    end
end
