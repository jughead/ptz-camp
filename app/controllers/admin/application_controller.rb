class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize

  private

    def authorize
      # current_user.has_role?(:admin)
    end
end
