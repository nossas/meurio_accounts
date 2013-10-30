class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter { session[:redirect_url] ||= params[:redirect_url] }

  def after_sign_in_path_for(resource)
    session.delete(:redirect_url) || "#{ENV["MR_USER_PATH"]}/#{current_user.id}"
  end
end
