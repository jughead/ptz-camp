# frozen_string_literal: true
class Admin::ParticipantsController < Admin::ApplicationController
  load_resource :camp
  before_action :load_and_authorize
  decorate_current_camp

  def index

  end

  def edit
  end

  def show
  end

  def create
    if @participant.save
      redirect_to({action: :index}, notice: 'The participant is created')
    else
      render :new
    end
  end

  def new
  end

  def update
    if @participant.update(update_params)
      redirect_to({action: :show}, notice: 'The participant is updated')
    else
      render :edit
    end
  end

  def destroy
    @participant.destroy
    redirect_to({action: :index}, notice: 'The participant is removed')
  end

  private

    def create_params
      params.require(:participant).permit(:role, :arrival, :departure, :delegation_id, :passport_scan, :tshirt, personal: PersonalData.attributes)
    end

    def update_params
      params.require(:participant).permit(:role, :arrival, :departure, :delegation_id, :passport_scan, :tshirt, personal: PersonalData.attributes)
    end

    def load_and_authorize
      if %w[new create].include?(action_name)
        build_resource
      else
        load_resource
      end
      authorize
    end

    def decorator
      Admin::ParticipantDecorator
    end

    def build_resource
      @participant = decorator.decorate(@camp.participants.new)
      if action_name == 'create'
        @participant.assign_attributes(create_params)
      end
    end

    def load_resource
      if %w[index].include?(action_name)
        @participants = @camp.participants.accessible_by(current_ability)
        @participants = @participants.where(delegation_id: params[:delegation_id]) if params[:delegation_id]
        apply_order
        @participants = decorator.decorate_collection(@participants)
      else
        @participant = @camp.participants.find_by(id: params[:id])
        @participant &&= decorator.decorate(@participant)
      end
    end

    def apply_order
      @participants = @participants.order(
        case params[:order_by]
        when 'delegation' then "delegation_id, personal->>'first_name', personal->>'last_name'"
        when 'name' then "personal->>'first_name', personal->>'last_name'"
        else
          {created_at: :desc}
        end)
    end

    def authorize
      if %w[index].include?(action_name)
        authorize! action_name.to_sym, {@camp => Participant}
      else
        authorize! action_name.to_sym, @participant
      end
    end
end
