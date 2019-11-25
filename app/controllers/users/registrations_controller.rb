module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :load_participant, only: :edit
    prepend_before_action :check_captcha, only: [:create]

    protected

    def update_resource(resource, params)
      if resource.identities.blank?
        super
      else
        resource.update_without_password(params)
      end
    end

    private

    def check_captcha
      unless verify_recaptcha
        self.resource = resource_class.new sign_up_params
        # resource.validate
        clean_up_passwords resource
        set_minimum_password_length
        respond_with_navigational(resource) { render :new }
      end
    end

    def load_participant
      @camp = CampFinder.new.current.find.decorate
      @participant = @camp.build_participant(current_user).decorate
    end

    def sign_up_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
end
