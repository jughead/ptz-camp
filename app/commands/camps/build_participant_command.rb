module Camps
  class BuildParticipantCommand
    def initialize(camp, user)
      @camp = camp
      @user = user
    end

    def execute
      Participant.new(camp: @camp, user: @user, personal: {}).decorate
    end
  end
end
