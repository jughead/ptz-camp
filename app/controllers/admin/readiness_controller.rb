# frozen_string_literal: true

module Admin
  class ReadinessController < ActionController::Base
    def show
      render(plain: 'OK')
    end
  end
end
