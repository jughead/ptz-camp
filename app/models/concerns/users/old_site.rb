module Users
  module OldSite
    extend ActiveSupport::Concern

    def valid_password?(password)
      valid_old_password?(password) || super
    end

    def valid_old_password?(password)
      return false if encrypted_password.blank?
      bcrypt   = ::BCrypt301::Password.new(encrypted_password)
      old_site_pepper = Rails.application.secrets.old_site_pepper
      password = ::BCrypt301::Engine.hash_secret("#{password}#{old_site_pepper}", bcrypt.salt)
      Devise.secure_compare(password, encrypted_password)
    end

  end
end
