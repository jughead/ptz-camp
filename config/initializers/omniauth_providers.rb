# frozen_string_literal: true
module PtzCamp
  module OmniAuth
    module_function

    def providers
      @providers ||= []
    end

    def fa_icon_class_suffixes
      @fa_icon_class_suffixes ||= {}
    end

    def fa_icon_class_suffix(name)
      fa_icon_class_suffixes[name]
    end

    def register(gem_name, parameters={})
      name = (parameters[:name] || gem_name).to_s
      icon_class = parameters.delete(:icon_class) || name

      key = ENV["#{name.upcase}_APP_ID"]
      secret = ENV["#{name.upcase}_APP_SECRET"]

      providers << name.to_sym
      fa_icon_class_suffixes[name.to_sym] = icon_class

      Devise.setup do |config|
        config.omniauth gem_name, key, secret, parameters
      end

    end
  end
end

# Do not mix the lines.
# Do not insert `register` calls in between.
# The order should be preserved for Identity providers enum.
PtzCamp::OmniAuth.register :google_oauth2, name: 'google', scope: 'email,profile'
PtzCamp::OmniAuth.register :vkontakte, icon_class: 'vk', scope: 'email', https: '1'
PtzCamp::OmniAuth.register :facebook

# Insert new providers here
