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
  end

  def camp_rules
    can [:index, :show, :new, :edit, :create, :update, :dashboard], Camp
  end

  def delegation_rules
    can [:index, :new, :create, :edit, :update, :show, :destroy], Delegation
  end

  def day_schedule_rules
    can [:edit, :update, :index], DaySchedule
  end

  def messages_rules
    return unless user.superadmin?
    can [:index, :new, :create], Message, user_id: user.id
  end

  def participant_rules
    can [:index, :edit, :update, :show], Participant
  end
end
