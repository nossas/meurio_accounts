class RegistrationsController < Devise::RegistrationsController
  before_action :set_organizations, only: [:new, :create]

  def after_sign_up_path_for(resource)
    sign_in_after_sign_up_path(params: params)
  end

  private
  def set_organizations
    @organizations = Organization.order(:city)
  end
end
