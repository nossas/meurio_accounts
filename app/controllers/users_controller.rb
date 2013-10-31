class UsersController < InheritedResources::Base
  def update
    update! do |success, failure|
      success.html { redirect_to "#{ENV['MR_USER_PATH']}/#{@user.id}" }
      failure.html { render :edit }
    end
  end

  def permitted_params
    {:user => params.require(:user).permit(:image, :first_name, :last_name, :email, :bio, :birthdate, :profession, :home_postcode, :phone, :secondary_email, :gender, :public, :home_city, :home_state, :facebook_url, :twitter_url, :website)}
  end
end
