class CampFieldSets::UpdateCommand
  include Dry::Transaction

  ParamsSchema = Dry::Schema.JSON do
    required(:fields).array do
      schema do
        required(:name).filled(:string)
        required(:type).filled(:string)
        optional(:collection).array(:string)
        required(:required).filled(:bool)
      end
    end
  end

  step :parse_params
  step :validate_schema
  step :store

  private

  def parse_params(camp_field_set:, params:)
    @camp_field_set = camp_field_set
    Success(fields: JSON.parse(params.require(:camp_field_set).permit(:fields)[:fields]))
  rescue JSON::ParserError
    Failure('Non JSON data')
  end

  def validate_schema(fields)
    schema = ParamsSchema.call(fields)
    schema.to_monad
  end

  def store(input)
    @camp_field_set.fields = input.to_h[:fields]
    if @camp_field_set.save
      Success(@camp_field_set)
    else
      Failure(@camp_field_set.errors.full_messages.to_h)
    end
  end
end
