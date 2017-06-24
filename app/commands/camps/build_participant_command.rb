module Camps
  class BuildParticipantCommand
    def initialize(camp, user)
      @camp = camp
      @user = user
    end

    def execute
      @camp.participants.where(user: @user).first_or_initialize
    end
  end
end
