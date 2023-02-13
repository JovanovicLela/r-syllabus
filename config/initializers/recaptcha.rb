# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
  config.site_key  = '6Lfrk3skAAAAAHAVW6CAtCK2dkzx6DkTjIeah1Xj'
  config.secret_key = '6Lfrk3skAAAAAHxi9mWCu1jLxu6eTuQOeRsYXLyC'
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end
