class Admin::ApplicationController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :authorize

  private

    def authorize
      # current_user.has_role?(:admin)
      unless current_user.admin?
        redirect_to root_path, status: 403, notice: 'Please, sign in'
      end
    end
end
