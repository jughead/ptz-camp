# frozen_string_literal: true
module OmniauthHelper
  def omniauth_icon(provider)
    fa_icon(PtzCamp::OmniAuth.fa_icon_class_suffix(provider))
  end
end
