class Admin::ApplicationController < ActionController::Base
  include CampDecoration
  include CanCanRescueFrom

  layout 'admin'
  before_action :authenticate_user!

  private

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def self.load_current_camp
      before_action :load_current_camp
      decorate_current_camp
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
