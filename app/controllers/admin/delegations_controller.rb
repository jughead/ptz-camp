class Admin::DelegationsController < Admin::ApplicationController
  load_resource :camp
  load_and_authorize_resource through: :camp

  decorate_current_camp
  before_action :decorate

  def index
  end

  def new
  end

  def edit
  end

  def update
    if @delegation.update(update_params)
      redirect_to({action: :index}, notice: 'The delegation is updated')
    else
      render :new
    end
  end

  def create
    if @delegation.save
      redirect_to({action: :index}, notice: 'The delegation is added')
    else
      render :new
    end
  end

  def destroy
    @delegation.destroy
    redirect_to({action: :index}, notice: 'The delegation is deleted')
  end

  def show
    @participants = Admin::ParticipantDecorator.decorate_collection(@delegation.participants)
  end

  def copy_from_last
    Camps::CopyFromLastCommand.new(@camp).execute
    redirect_to({action: :index}, notice: 'The delegations have been copied')
  end

  private

    def create_params
      params.require(:delegation).permit(:name, :max_teams)
    end

    def update_params
      params.require(:delegation).permit(:name, :max_teams)
    end

    def decorator_class
      Admin::DelegationDecorator
    end

    def decorate
      @delegations &&= decorator_class.decorate_collection(@delegations)
      @delegation &&= decorator_class.decorate(@delegation)
    end
end
