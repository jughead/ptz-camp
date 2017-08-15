module CanCanRescueFrom
  extend ActiveSupport::Concern

  included do
    rescue_from CanCan::AccessDenied, with: :not_authorized
  end

  private

    def not_authorized(exception)
      Rails.logger.info "CanCan::AccessDenied. Subject Class: #{exception.subject.class}, Action: #{exception.action}, Subject: #{exception.subject}"
      redirect_to root_path, alert: not_authorized_message(exception)
    end

    def not_authorized_message(exception)
      if user_signed_in?
        exception.message
      else
        'Please sign in.'
      end
    end
end
