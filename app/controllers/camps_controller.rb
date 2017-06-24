class CampsController < ApplicationController
  load_camp
  decorate_current_camp

  def show
    if can? :sign_up, @camp
      @participant = ParticipantForm.new(@camp, current_user)
    else
      @participant = @camp.build_participant(current_user).decorate
    end
  end
end
