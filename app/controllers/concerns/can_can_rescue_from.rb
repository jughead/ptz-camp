module CanCanRescueFrom
  extend ActiveSupport::Concern

  included do
    rescue_from CanCan::AccessDenied, with: :not_authorized
  end

  private

    def not_authorized(exception)
      Rails.logger.info "CanCan::AccessDenied. Subject Class: #{exception.subject.class}, Action: #{exception.action}, Subject: #{exception.subject}"
      respond_to do |format|
        format.html do
          redirect_to root_path, alert: not_authorized_message(exception)
        end

        format.json do
          render json: { error: not_authorized_message(exception) }, status: 403
        end
      end
    end

    def not_authorized_message(exception)
      if user_signed_in?
        exception.message
      else
        'Please sign in.'
      end
    end
end
