module Camps
  class BuildParticipantCommand
    def initialize(camp, user)
      @camp = camp
      @user = user
    end

    def execute
      if @user.guest?
        Participant.new(camp: @camp, user: @user)
      else
        @camp.participants.where(user: @user).first_or_initialize
      end
    end
  end
end
