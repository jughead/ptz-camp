module Participants
  class UnusedDecorator < ApplicationDecorator
    def name
      "#{personal.first_name} #{personal.last_name} (#{mask(user.email)})"
    end

    def as_json(*args)
      {name: name, id: id}.as_json(*args)
    end

    private

    def mask(email)
      email
    end
  end
end



