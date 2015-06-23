if Rails.env.test?
  ENV["MR_USER_PATH"] = 'http://127.0.0.1/users'
  ENV["API_TOKEN"] = '123'
  ENV['DEVISE_SECRET_KEY'] = 'devise_secret_key'
end
