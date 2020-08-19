# frozen_string_literal: true

class Admin::CampsController < Admin::ApplicationController
  load_and_authorize_resource :camp

  def new
    decorate_current_camp
  end

  def create
    decorate_current_camp
    if @camp.save
      flash[:notice] = 'The camp has been created successfully'
      redirect_to action: :index
    else
      render action: :new
    end
  end

  def index
    decorate_current_camp
    @camps = @camps.order(created_at: :desc)
  end

  def edit
    decorate_current_camp
  end

  def show
    decorate_current_camp
    @food_limitations = Camps::FoodLimitations.new(@camp.object).participants(Admin::ParticipantDecorator)
  end

  def update
    decorate_current_camp
    if @camp.update(update_params)
      flash[:notice] = 'The camp has been updated successfully'
      redirect_to action: :edit
    else
      render action: :edit
    end
  end

  def dashboard
    decorate_current_camp
    @participants = @camp.participants
  end

  def badges
    @participants = @camp.participants.order(created_at: :desc).decorate
    decorate_current_camp
    render :badges, layout: 'badges'
  end

  def download_participants
    @participants = @camp.participants
    temp_file = Camps::GenerateParticipantsCsvCommand.new(@camp).execute
    send_file temp_file.path, type: 'text/csv', disposition: 'attachment', filename: 'participants.csv'
  end

  private

  def update_params
    params.require(:camp).permit(:title, :slug, :telegram_intro, :front_page, :registration)
  end

  def create_params
    params.require(:camp).permit(:title, :slug, :telegram_intro, :start_date, :finish_date, :front_page)
  end
end
