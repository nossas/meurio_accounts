if Rails.env.test?
  ENV["MR_USER_PATH"] = 'http://127.0.0.1/users'
end
