class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= super || GuestUser.instance
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
end
