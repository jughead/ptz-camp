class Ability
  include CanCan::Ability
  attr_reader :user

  def initialize(user)
    @user = user
    participants_ability
  end

  def can(a, c, *args, &block)
    case c
    when Class
      can(a, [c, "#{c.name}Decorator".constantize], *args, &block)
    else
      super
    end
  end

  def participants_ability
    can :sign_up, Camp do |camp|
      user.participations.where(camp_id: camp.id).blank?
    end

    can [:edit, :update, :show], Participant do |participant|
      participant.persisted? && participant.user_id == user.id
    end
  end
end
