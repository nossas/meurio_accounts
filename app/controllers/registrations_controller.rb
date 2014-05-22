class RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    sign_in_after_sign_up_path(params: params)
  end
end
