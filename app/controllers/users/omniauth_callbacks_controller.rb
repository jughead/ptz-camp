# frozen_string_literal: true
module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def self.has_omniauth_provider(*names)
      names.each do |name|
        name = name.to_sym
        define_method name do
          fetch(name)
          respond(name)
        end
      end
    end

    has_omniauth_provider *PtzCamp::OmniAuth.providers

    def failure
      redirect_to root_path
    end

    private

      def fetch(kind)
        cmd = Users::FromOmniauthCommand.new(data)
        cmd.execute
        @user = cmd.user
      end

      def data
        request.env['omniauth.auth']
      end

      def respond(kind)
        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          set_flash_message :notice, :success, kind: kind if is_navigational_format?
        else
          session['devise.provider_data'] = data
          redirect_to new_user_registration_url
        end
      end
  end
end
