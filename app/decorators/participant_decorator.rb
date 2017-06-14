class ParticipantDecorator < ApplicationDecorator

  def user
    object.user || GuestUser.instance
  end

  def requires_registration_info?
    user.guest?
  end

  def form_path
    if persisted?
      h.participant_path(self)
    else
      h.participants_path(self)
    end
  end
end
