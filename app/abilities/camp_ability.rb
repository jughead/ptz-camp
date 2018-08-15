class CampAbility
  include CanCan::Ability

  def initialize(user, camp)
    @user = user
    @camp = camp
    teams_rules
    participant_rules
  end

  def participant
    @participant ||= Camps::BuildParticipantCommand.new(@camp, @user).execute
  end

  private

  def participant_is_coach?
    participant.persisted? && participant.has_role?(:coach)
  end

  def teams_rules
    if participant_is_coach?
      can :index_my, Team, delegation: participant.delegation
      can :create, Team, delegation: participant.delegation
      can :destroy, Team, delegation: participant.delegation
    end
  end

  def participant_rules
    can :index_unused, Participant, delegation: participant.delegation if participant_is_coach?
  end
end
