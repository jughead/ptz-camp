class Ability
  include CanCan::Ability
  attr_reader :user

  def initialize(user)
    @user = user
    participants_ability
  end

  def participants_ability
    can :sign_up, Camp do |camp|
      user.participations.where(camp_id: camp.id).blank?
    end
  end
end
