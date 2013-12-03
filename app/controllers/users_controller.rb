class UsersController < InheritedResources::Base
  load_and_authorize_resource
  before_filter(only: :edit) { session.delete(:flash) }
  before_action(only: [:edit, :update]) { @user = current_user if @user.nil? or not current_user.admin? }

  def update
    @user.availability = params[:user][:availability]
    @user.skills = params[:user][:skills]
    @user.topics = params[:user][:topics]
    
    update! do |success, failure|
      success.html { redirect_to edit_user_path(current_user) }
      failure.html { render :edit }
    end
  end

  def ssi_redirect
    session.delete(:flash)
    redirect_to session.delete(:redirect_url)
  end

  def logout
    sign_out current_user
    redirect_to session.delete(:redirect_url) || root_path
  end

  def permitted_params
    {:user => params.require(:user).permit(:avatar, :first_name, :last_name, :email, :bio, :birthday, :profession, :postal_code, :phone, :secondary_email, :gender, :public, :facebook, :twitter, :website, :availability, :skills, :topics)}
  end
end
