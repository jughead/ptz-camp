module Api
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    include CanCanRescueFrom

    protected

    def current_ability
      @current_ability ||= Ability.new(current_user)
    end

    def current_user
      @current_user ||= super || GuestUser.instance
    end

    def camp_ability
      @camp_ability ||= CampAbility.new(current_user, @camp)
    end

    def render_model_errors(model)
      render json: { errors: model.errors.to_hash }, status: 422
    end
  end
end
