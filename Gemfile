source 'https://rubygems.org'
ruby '2.3.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'

#######################
# Asset extensions
#######################
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.4'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Adding bootstrap as we are lazy and non-frontend guys
gem 'bootstrap-sass', '~> 3.3.6'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Font Awesome
gem 'font-awesome-rails'
gem 'non-stupid-digest-assets'

########################
# Template extensions
########################
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Convenient form rendering
gem 'simple_form'
# Convenient and fast view handler
gem 'slim'

####################################
# Authentication, authorization, etc
####################################
gem 'devise'
gem 'omniauth-facebook'
gem 'omniauth-vkontakte'
gem 'omniauth-google-oauth2'
# Role base authorization
gem 'rolify'
gem 'cancancan'
gem "recaptcha", require: 'recaptcha/rails'

####################################
# Background job processing
gem 'sidekiq', '~> 4.2.10'

####################################
# External services
####################################
# Telegram API
gem 'telegram-bot-ruby'


####################################
# Misc
####################################
# Decorates models and everything
gem 'draper', '~> 3.0.0'
# Batch creation of records
gem 'activerecord-import'
# File upload
gem 'carrierwave'
gem 'cloudinary'
# For making structs with type validation
gem 'active_model_attributes'
gem 'activerecord-session_store'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'dotenv-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Open emails in browser instead of real send
  gem 'letter_opener'
  # gem 'i18n-debug'
end

group :production do
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
