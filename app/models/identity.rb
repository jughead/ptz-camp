# frozen_string_literal: true
class Identity < ApplicationRecord
  belongs_to :user

  enum provider: PtzCamp::OmniAuth.providers

  scope :by_auth, ->(auth){ where(provider: auth.provider, uid: auth.uid) }
end
