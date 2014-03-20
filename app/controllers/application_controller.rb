class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  prepend_before_action { session[:redirect_url] ||= params[:redirect_url] }
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action { session.delete(:flash) }
  before_action { session[:ssi_user_id] = current_user.id if current_user.present? }

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
    session[:ssi_user_id] = current_user.id
    redirect_url = session[:redirect_url] || params[:redirect_url]
    redirect_url ? ssi_redirect_path(redirect_url: redirect_url) : edit_user_path(current_user)
  end

  def after_sign_out_path_for(resource_or_scope)
    session.delete(:ssi_user_id)
    session[:redirect_url] ? ssi_redirect_path(redirect_url: session[:redirect_url]) : root_path
  end

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name]
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, request)
  end
end
