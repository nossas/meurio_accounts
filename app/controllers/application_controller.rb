class ApplicationController < ActionController::Base
  include CASino::CurrentUserHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  helper_method :current_account

  # prepend_before_action { session[:redirect_url] ||= params[:redirect_url] }
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action { session.delete(:flash) }
  # before_action { session[:ssi_user_id] = current_account.id if current_account.present? }

  skip_before_action :verify_authenticity_token

  rescue_from CanCan::AccessDenied do |exception|
    puts "CanCan alert: #{exception.message}"
    redirect_to '/login', :alert => exception.message
  end

  # def after_sign_in_path_for(resource)
  #   session[:ssi_user_id] = current_account.id
  #   redirect_url = session[:redirect_url] || params[:redirect_url]
  #   redirect_url ? ssi_redirect_path(redirect_url: redirect_url) : edit_user_path(current_account)
  # end
  #
  # def after_sign_out_path_for(resource_or_scope)
  #   session.delete(:ssi_user_id)
  #   session[:redirect_url] ? ssi_redirect_path(redirect_url: session[:redirect_url]) : root_path
  # end

  def current_account
    User.find_by_email(current_user.try(:username))
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [
      :first_name,
      :last_name,
      :email,
      :ip,
      :application_slug,
      :organization_ids => []
    ]
  end

  def current_ability
    @current_ability ||= Ability.new(current_account, request)
  end
end
