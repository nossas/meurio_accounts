class UsersController < InheritedResources::Base
  load_and_authorize_resource
  skip_authorize_resource :only => [:create, :ssi_redirect, :validate_email, :create_password]
  skip_before_action :verify_authenticity_token, only: :create
  before_action(only: [:edit, :update]) { @user = current_user if @user.nil? or not current_user.admin? }
  respond_to :json

  def update
    @user.availability = params[:user][:availability]
    @user.skills = params[:user][:skills]
    @user.topics = params[:user][:topics]

    update! do |success, failure|
      success.html { redirect_to session[:redirect_url].present? ? session[:redirect_url] : "#{ENV['MR_PATH']}/users/#{current_user.id}" }
      failure.html { render :edit }
    end
  end

  def ssi_redirect
    session.delete(:flash)
    puts "Redirect URL (in users#ssi_redirect): #{session[:redirect_url]}"
    redirect_to session.delete(:redirect_url) || params[:redirect_url]
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

  def permitted_params
    {:user => params.require(:user).permit(:avatar, :first_name, :last_name, :email, :bio, :birthday, :profession, :postal_code, :phone, :secondary_email, :gender, :public, :facebook, :twitter, :website, :availability, :skills, :topics, :ip, :application_slug)}
  end
end
