class CampFieldSetContract < Dry::Validation::Contract
  params do
    required(:fields).filled(:string)
  end
end
