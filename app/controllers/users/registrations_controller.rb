module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :load_participant, only: :edit

    protected

    def update_resource(resource, params)
      if resource.identities.blank?
        super
      else
        resource.update_without_password(params)
      end
    end

    private

    def load_participant
      @camp = CampFinder.new.current.find.decorate
      @participant = @camp.build_participant(current_user).decorate
    end

    def sign_up_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
end
