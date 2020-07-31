class Participants::RegisterCommand
  include Dry::Transaction

  ParamsSchema = Dry::Schema::Params do 
    required(:arrival).filled(:date)
    required(:departure).filled(:date)
    required(:delegation_id).filled(:integer)
    optional(:passport_scan).maybe(:file?)
    required(:personal).hash do
      
    end
  end

  step :init

  private

  def init(camp:, current_user:, params:)
    @camp = camp
    @current_user = current_user
    @params = params

    @participant = @camp.build_participant(@current_user)
    @participant.assign_attributes(participant_params)
    if requires_registration?
      @user = User.new(user_params)
      @participant.user = user
    end
    @participant.personal.first_name ||= @participant.user.name&.split&.first
    @participant.personal.last_name ||= @participant.user.name&.split&.last
  end

  def requires_registration?
    @current_user.guest?
  end
end
