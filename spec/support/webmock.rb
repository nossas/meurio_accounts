RSpec.configure do |config|
  config.before(:each) do
    stub_request(:post, "https://api.mailchimp.com/2.0/lists/subscribe")
    stub_request(:get, /http\:\/\/gravatar\.com\/avatar\/./).
      to_return(:status => 200, :body => "", :headers => {})
  end
end
