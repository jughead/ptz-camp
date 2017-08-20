class Ability
  include CanCan::Ability
  attr_reader :user

  def initialize(user)
    @user = user
    participants_rules
    pages_rules
    teams_rules
  end

  def can(a, c, *args, &block)
    case c
    when Class
      can(a, [c, "#{c.name}Decorator".constantize], *args, &block)
    else
      super
    end
  end

  def participants_rules
    can :sign_up, Camp do |camp|
      camp.not_started? && user.participations.where(camp_id: camp.id).blank?
    end

    can [:edit, :update, :show], Participant do |participant|
      participant.persisted? && participant.user_id == user.id
    end
  end

  def pages_rules
    can :show, Page, state: :openned
    can :show, Page if user.admin?
  end

  def teams_rules
    can :index, Team
  end
end
