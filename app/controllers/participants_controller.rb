class ParticipantsController < ApplicationController
  load_camp_parent
  decorate_current_camp
  load_and_authorize_resource through: :camp, only: [:edit, :show, :update, :index]

  def new
    authorize! :sign_up, @camp
    @participant = ParticipantForm.new(@camp, current_user)
  end

  def index
    @participants = @participants.ordered_by_delegation.ordered_by_name.decorate
  end

  def create
    authorize! :sign_up, @camp
    @participant = ParticipantForm.new(@camp, current_user, create_params)

    @recaptcha_ok = !@participant.requires_registration? || verify_recaptcha

    if @recaptcha_ok && @participant.save
      redirect_to @camp, notice: 'Welcome to the camp!'
    end
  end

  def edit
    @participant = ParticipantForm.new(@camp, current_user)
  end

  def show
    redirect_to action: :edit
  end

  def update
    @participant = ParticipantForm.new(@camp, current_user, create_params)
    if @participant.save
      redirect_to @camp, notice: 'The participation is updated.'
    else
      render :edit
    end
  end

  private

    def create_params
      params.require(:participant)
    end
end
