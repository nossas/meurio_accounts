class SegmentSubscriptionsController < InheritedResources::Base
  skip_before_action :verify_authenticity_token, only: [:create]
  belongs_to :user
  respond_to :json

  def create
    begin
      if organization = Organization.find(params[:segment_subscription][:organization_id])
        Gibbon::API.lists.static_segment_members_add(
          id: organization.mailchimp_list_id,
          seg_id: organization.multitude_mailchimp_segment_id,
          batch: [{ email: User.find(params[:user_id]).try(:email) }]
        )
      end
    rescue Exception => e
      Rails.logger.error e
    end

    head :ok
  end

  def permitted_params
    {:segment_subscription => params.require(:segment_subscription).permit(:organization_id, :segment_id)}
  end
end
