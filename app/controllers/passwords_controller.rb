class PasswordsController < Devise::PasswordsController
  protected

  def after_resetting_password_path_for(resource)
    params[:user][:email] = resource.email
    sign_in_after_sign_up_path(params: params)
  end
end
