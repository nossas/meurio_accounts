class ApplicationController < ActionController::Base
  include CASino::CurrentUserHelper
  include CASino::ProcessorConcern::LoginTickets

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  helper_method :current_account

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user_from_token!
  before_filter :avoid_devise_to_login
  before_filter :avoid_devise_login_page
  before_filter :set_default_language

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
      :organization_id,
      :application_slug,
      memberships_attributes: [:organization_id]
    ]
  end

  def current_ability
    @current_ability ||= Ability.new(current_account, request)
  end

  def sign_in_with_casino email, password, redirect_url = ''
    my_processor = processor(:LoginCredentialAcceptor)
    my_processor.process(
      {
        username: email,
        password: password,
        lt: acquire_login_ticket.ticket,
        service: redirect_url
      },
      request.user_agent
    )
  end

  private

  # TODO: we need a way to login with Casino without passing a password as argument
  # https://github.com/rbCAS/CASino/issues/40
  def authenticate_user_from_token!
    user_email = params[:user_email]
    user = user_email && User.find_by_email(user_email)

    if user && Devise.secure_compare(user.auth_token, params[:user_token])
      old_password = user.encrypted_password
      new_password = SecureRandom.hex

      user.update_attribute :password, new_password

      begin
        sign_in_with_casino user.email, new_password, params[:service]
      rescue Exception => e
        Appsignal.add_exception e
        Rails.logger e
      end

      user.update_column :encrypted_password, old_password
    end
  end

  def avoid_devise_to_login
    session.delete("warden.user.user.key")
  end

  def avoid_devise_login_page
    if request.path == "/users/sign_in"
      redirect_to login_path
    end
  end

  def set_default_language
    I18n.locale = I18n.default_locale
  end
end
