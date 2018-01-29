class CampAbility
  include CanCan::Ability

  def initialize(user, camp)
    @user = user
    @camp = camp
    teams_rules
  end

  def participant
    @participant ||= Camps::BuildParticipantCommand.new(@camp, @user).execute
  end

  private

  def participant_is_coach?
    participant.persisted? && participant.has_role?(:coach)
  end

  def teams_rules
    can :index_my, Team if participant_is_coach?
  end
end
