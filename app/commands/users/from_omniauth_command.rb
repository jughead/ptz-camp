module Users
  class FromOmniauthCommand
    DifferentUserError = Class.new(StandardError)

    attr_reader :identity, :user

    def initialize(auth)
      @auth = auth
    end

    def execute
      find_or_set_identity
      find_or_set_user
      consider_connection
      assign_new_attributes
      update if existing_user?
    end

    private

      attr_reader :auth

      def different_user?
        user.persisted? && identity.persisted? && identity.user_id != user.id
      end

      def consider_connection
        if different_user?
          change_user
        else
          connect
        end
      end

      def change_user
        @user = identity.user
      end

      def connect
        identity.user = user
      end

      def find_or_set_identity
        @identity = Identity.by_auth(auth).first_or_initialize
      end

      def find_or_set_user
        @user = if auth_email
          User.find_or_initialize_by(email: auth_email)
        else
          User.new
        end
      end

      def auth_user_attributes
        AttributesFromOmniauthCommand.new(auth).execute
      end

      def auth_email
        auth.info.email
      end

      def assign_new_attributes
        user.attributes = auth_user_attributes
      end

      def existing_user?
        user.persisted?
      end

      def update
        user.save!
        identity.save!
      end
  end
end
