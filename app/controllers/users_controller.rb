# The UserController#create is not been used! It's the DeviseRegistration instead

class UsersController < InheritedResources::Base
  load_and_authorize_resource
  skip_authorize_resource :only => [:create, :update, :validate_email, :create_password, :sign_in]
  skip_before_action :verify_authenticity_token, only: [:create, :update]
  before_action :set_allowed_user, only: [:edit, :update]

  respond_to :json

  def update
    @user.availability = params[:user][:availability] if params[:user][:availability].present?
    @user.skills = params[:user][:skills] if params[:user][:skills].present?
    @user.topics = params[:user][:topics] if params[:user][:topics].present?
    @user.ip = request.remote_ip

    update! do |success, failure|
      # TODO: find out why we are using redirect_url here, if it's useless, take it off
      success.html { redirect_to session[:redirect_url].present? ? session[:redirect_url] : "#{ENV['MR_PATH']}/users/#{current_account.id}" }
      failure.html { render :edit }
    end
  end

  def sign_in
    sign_in_with_casino params[:user][:email], params[:user][:password]
  end

  def validate_email
    if request.post?
      if user = User.find_by_email(params[:email])
        user.send_reset_password_instructions
        redirect_to root_path(flash: 'Enviamos um email para você criar sua senha')
      else
        redirect_to new_user_registration_path(email: params[:email], first_name: params[:first_name], last_name: params[:last_name])
      end
    end
  end

  # TODO: We need an API, for God sake!
  def set_allowed_user
    unless request.format.json?
      @user = current_account if @user.nil? || !current_account.admin?
    end
  end

  def permitted_params
    { user: params.require(:user).permit(
      :avatar, :first_name, :last_name, :email, :bio, :birthday, :profession, :postal_code, :phone,
      :secondary_email, :gender, :public, :facebook, :twitter, :website, :availability, :skills, :topics,
      :ip, :application_slug, :password, :organization_id, memberships_attributes: [:organization_id])
    }
  end
end
