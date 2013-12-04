class UsersController < InheritedResources::Base
  load_and_authorize_resource 
  skip_authorize_resource :only => [:ssi_redirect, :validate_email, :create_password]
  before_action(only: [:edit, :update]) { @user = current_user if @user.nil? or not current_user.admin? }

  def update
    @user.availability = params[:user][:availability]
    @user.skills = params[:user][:skills]
    @user.topics = params[:user][:topics]
    
    update! do |success, failure|
      success.html { redirect_to "#{ENV['MR_PATH']}/users/#{current_user.id}" }
      failure.html { render :edit }
    end
  end

  def ssi_redirect
    session.delete(:flash)
    redirect_to session.delete(:redirect_url) || params[:redirect_url]
  end

  def validate_email
    if request.post?
      if User.find_by_email(params[:email]).present?
        redirect_to create_password_path(email: params[:email])
      else
        redirect_to new_user_registration_path(email: params[:email])
      end
    end
  end

  def create_password
    if request.post?
      user = User.find_by_email(params[:email])
      user.password = params[:password]
      user.save
      sign_in(user)
      redirect_to ssi_redirect_path(redirect_url: edit_user_path(current_user, flash: "Sua senha foi cadastrada com sucesso"))
    end
  end

  def permitted_params
    {:user => params.require(:user).permit(:avatar, :first_name, :last_name, :email, :bio, :birthday, :profession, :postal_code, :phone, :secondary_email, :gender, :public, :facebook, :twitter, :website, :availability, :skills, :topics)}
  end
end
