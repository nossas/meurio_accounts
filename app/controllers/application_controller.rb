class ApplicationController < ActionController::Base
  include CASino::CurrentUserHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  helper_method :current_account

  before_action :configure_permitted_parameters, if: :devise_controller?

  skip_before_action :verify_authenticity_token

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/login', alert: exception.message
  end

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
