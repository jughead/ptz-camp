class Admin::ApplicationController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  rescue_from CanCan::AccessDenied, with: :not_authorized

  private

    def not_authorized(exception)
      puts exception.subject
      Rails.logger.info "CanCan::AccessDenied. Subject: #{exception.subject.class}, Action: #{exception.action}"
      redirect_to root_path, alert: not_authorized_message(exception)
    end

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def not_authorized_message(exception)
      if user_signed_in?
        exception.message
      else
        'Please sign in.'
      end
    end

    def self.load_current_camp
      before_action :load_current_camp
      decorate_current_camp
    end

    def self.decorate_current_camp
      before_action :decorate_current_camp
    end

    def load_current_camp
      return if @camp
      @camp = CampFinder.new.current.find
      decorate_current_camp
    end

    def decorate_current_camp
      @camp &&= Admin::CampDecorator.decorate(@camp)
    end

end
