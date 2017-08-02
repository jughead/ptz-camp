class ParticipantForm
  attr_reader :user, :camp, :participant
  USER_METHODS = %i{name email password password_confirmation}.freeze
  PARTICIPANT_METHODS = %i{arrival delegation_id departure passport_scan tshirt personal}.freeze

  delegate *USER_METHODS, to: :user
  delegate *PARTICIPANT_METHODS, :model_name, :to_key, :to_model, :persisted?, to: :participant
  attr_reader :errors

  def initialize(camp, current_user, params = nil)
    @camp = camp
    @current_user = current_user
    @user = User.new
    @params = params
    @errors = Errors.new(self)
    set
  end

  def valid?
    validate
    participant.errors.empty? && user.errors.empty?
  end

  def save
    valid? && store
  end

  def password_hint
    "#{Devise.password_length.min} characters minimum"
  end

  def requires_registration?
    @current_user.guest?
  end

  private

    def set
      @participant = camp.build_participant(@current_user)
      @participant.assign_attributes(participant_params)
      if requires_registration?
        @user = User.new(user_params)
        @participant.user = user
      end
      @participant.personal.first_name ||= @participant.user.name&.split&.first
      @participant.personal.last_name ||= @participant.user.name&.split&.last
    end

    def store
      ActiveRecord::Base.transaction do
        participant.save!
      end
      true
    rescue ActiveRecord::RecordInvalid
      false
    end

    def validate
      @participant.valid?
      @participant.user.valid? if requires_registration?
    end

    def participant_params
      @params&.permit(:arrival, :departure, :delegation_id, :passport_scan, :tshirt, personal: PersonalData.attributes) || {}
    end

    def user_params
      @params&.permit(:email, :name, :password, :password_confirmation) || {}
    end


    class Errors
      def initialize(form)
        @form = form
      end

      def present?
        participant.errors.present? || user.errors.present?
      end

      def [](method)
        choose(method).errors[method]
      end

      def full_messages_for(method)
        choose(method).full_messages_for(method)
      end

      private

        delegate :participant, :user, to: :@form

        def choose(method)
          if USER_METHODS.include?(method.to_sym)
            user
          else
            participant
          end
        end
    end

end
