if Rails.env.production? || Rails.env.staging?
  raise "MAILCHIMP_LIST_ID is missing" if ENV["MAILCHIMP_LIST_ID"].nil?
  raise "MAILCHIMP_API_KEY is missing" if ENV["MAILCHIMP_API_KEY"].nil?
end
