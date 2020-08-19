class AdminAbility
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    return unless user.admin?

    can :get, :home
    delegation_rules
    camp_rules
    day_schedule_rules
    participant_rules
    messages_rules
    page_rules
    public_files_rules
    teams_rules
    events_rules
  end

  def can?(a, c)
    case c
    when Draper::CollectionDecorator, Draper::Decorator
      can?(a, c.object)
    else
      super
    end
  end

  def camp_rules
    can %i[index badges show new edit create update dashboard download_participants], Camp
  end

  def delegation_rules
    can %i[index new create edit update show], Delegation
    can [:copy_from_last], Camp
    can [:copy_from_last], Delegation
    can :destroy, Delegation if user.superadmin?
  end

  def day_schedule_rules
    can %i[edit update index], DaySchedule
  end

  def messages_rules
    return unless user.superadmin?

    can %i[index new create], Message
  end

  def participant_rules
    can %i[index new create edit update show], Participant
    can :destroy, Participant if user.superadmin?
  end

  def page_rules
    can %i[index edit update create new destroy], Page
  end

  def public_files_rules
    can %i[index edit update create new destroy], PublicFile
  end

  def teams_rules
    can %i[index edit update create new destroy], Team
  end

  def events_rules
    can %i[index edit update create new destroy], Event
  end
end
