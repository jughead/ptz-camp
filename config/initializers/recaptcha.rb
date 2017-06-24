Recaptcha.configure do |config|
  config.site_key  =  ENV['RECAPTCHA_API_KEY']
  config.secret_key = ENV['RECAPTCHA_API_SECRET']
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end
