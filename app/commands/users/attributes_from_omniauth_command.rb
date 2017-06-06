# frozen_string_literal: true
module Users
  class AttributesFromOmniauthCommand
    def initialize(auth)
      @auth = case auth
      when Hash
        OmniAuth::AuthHash.new(auth)
      else
        auth
      end
    end

    def execute
      p @auth
      p @auth.info.name
      data = {
        name: @auth.info.name,
        email: @auth.info.email,
      }
      data.reject{|_, v| v.blank?}.to_h
    end

  end
end
