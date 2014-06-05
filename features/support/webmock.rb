require 'webmock/cucumber'
WebMock.disable_net_connect!(:allow_localhost => true)

Before do
  stub_request(:post, "https://us6.api.mailchimp.com/2.0/stub_chain/and-return")
  stub_request(:post, "https://us6.api.mailchimp.com/2.0/lists/subscribe")
  stub_request(:get, /.*gravatar.*/).to_return(Net::HTTPNotFound.new(1.0, 404, 'OK'))
end