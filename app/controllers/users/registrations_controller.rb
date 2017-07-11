module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :load_participant, only: :edit

    protected

    def update_resource(resource, params)
      if resource.password_required?
        super
      else
        resource.update_without_password(params)
      end
    end

    def load_participant
      @camp = CampFinder.new.current.find.decorate
      @participant = @camp.build_participant(current_user).decorate
    end
  end
end
