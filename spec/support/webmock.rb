RSpec.configure do |config|
  config.before(:each) do
    stub_request(:post, "https://api.mailchimp.com/2.0/lists/subscribe")
  end
end
