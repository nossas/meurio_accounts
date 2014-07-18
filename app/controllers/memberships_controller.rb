class MembershipsController < InheritedResources::Base
  load_and_authorize_resource
  skip_before_action :verify_authenticity_token, only: [:create]
  belongs_to :user
  respond_to :json

  def permitted_params
    {:membership => params.require(:membership).permit(:organization_id)}
  end
end
