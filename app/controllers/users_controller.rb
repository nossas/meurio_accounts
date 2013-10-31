class UsersController < InheritedResources::Base
  load_and_authorize_resource

  def update
    update! do |success, failure|
      success.html { redirect_to "#{ENV['MR_USER_PATH']}/#{@user.id}" }
      failure.html { render :edit }
    end
  end

  def permitted_params
    {:user => params.require(:user).permit(:image, :first_name, :last_name, :email, :bio, :birthday, :profession, :postal_code, :phone, :secondary_email, :gender, :public, :facebook, :twitter, :website)}
  end
end
