# frozen_string_literal: true
module Users
  class NewWithSessionCommand
    def initialize(user, params, session)
      @user = user
      @params = params
      @session = session
    end

    def execute
      if omniauth_data?
        set_omniauth_data
        set_random_password
        sync_omniauth_email_verification
        set_identity
      end
      set_params
      @user
    end

    private

      def omniauth_data?
        omniauth
      end

      def omniauth
        @omniauth ||= OmniAuth::AuthHash.new(@session['devise.provider_data'])
      end

      def attributes_from_omniauth
        Users::AttributesFromOmniauthCommand.new(omniauth).execute
      end

      def set_omniauth_data
        @user.assign_attributes(attributes_from_omniauth)
      end

      def set_random_password
        @user.password = Devise.friendly_token[0,20] if @user.new_record?
      end

      def sync_omniauth_email_verification
        @user.sync_omniauth_email_verification(omniauth)
      end

      def set_params
        @user.assign_attributes(@params)
      end

      def set_identity
        identity = @user.identities.by_auth(omniauth).first_or_initialize
        @user.identities << identity if identity.new_record?
      end
  end
end
