class Ability
  include CanCan::Ability
  attr_reader :user

  def initialize(user)
    @user = user
    participants_rules
    pages_rules
    teams_rules
    events_rules
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
      camp.registration_openned? && user.participations.where(camp_id: camp.id).blank?
    end

    can [:edit, :update, :show], Participant do |participant|
      participant.persisted? && participant.user_id == user.id
    end

    can :index, Participant
  end

  def pages_rules
    can :show, Page, state: :openned
    can :show, Page if user.admin?
  end

  def teams_rules
    can :index, Team
  end

  def events_rules
    if user.persisted?
      can :opt_in, Event do |event|
        event.camp.participants.where(user: user).any? &&
        EventParticipation.joins(:event).
          merge(Event.where(camp_id: event.camp_id)).
          goes.joins(:participant).merge(
            Participant.where(user: user)
          ).merge(
            EventParticipation.where(event_id: event.id).or \
            EventParticipation.where(event_id: event.restricted_events.select(:id))
          ).none?
      end

      can :opt_out, Event do |event|
        event.camp.participants.where(user: user).any? &&
        EventParticipation.goes.joins(:participant).
          where(event_id: event).merge(
            Participant.where(user: user)
          ).exists?
      end
    end

    can :show, Event
  end
end
