module Camps
  class FoodLimitations
    def initialize(camp)
      @camp = camp
    end

    def participants(decorator)
      decorator.decorate_collection @camp.participants.where("personal->>'food_limitations' != ''")
    end
  end
end
