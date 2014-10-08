class APIController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter do
    authenticate_or_request_with_http_token do |token, options|
      token == ENV["API_TOKEN"]
    end
  end
end
