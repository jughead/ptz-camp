class ApplicationController < ActionController::Base
  include CampDecoration
  include CanCanRescueFrom
  include CampLoader

  protect_from_forgery with: :exception

  protected

  def current_user
    @current_user ||= super || GuestUser.instance
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def decorate_current_camp
    @camp &&= CampDecorator.decorate(@camp)
  end

  def user_signed_in?
    current_user.present?
  end

  helper_method :devise_mapping

end
