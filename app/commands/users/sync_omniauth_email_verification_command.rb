module Users
  class SyncOmniauthEmailVerificationCommand
    def initialize(user, auth)
      @user = user
      @auth = auth
    end

    def execute
      email_is_verified = @auth.info.email &&
        (@auth.info.verified || @auth.info.verified_email || @auth.extra.raw_info.email_verified == 'true')
      if @user.email.present? && email_is_verified
        @user.confirmed_at = Time.now
      end
    end
  end
end
