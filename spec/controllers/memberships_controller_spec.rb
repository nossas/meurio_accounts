require 'spec_helper'

describe MembershipsController do
  describe 'POST create' do
    before { @user = User.make! }
    before { @organization = Organization.make! }

    context 'when an organization_id is passed as parameter' do
      it 'should create a new membership' do
        expect {
          post(
            :create,
            user_id: @user.id,
            membership: {organization_id: @organization.id},
            format: :json,
            token: ENV["API_TOKEN"]
          )
        }.to change{ Membership.count }.by(1)
      end
    end

    context 'when no organization_id is passed as parameter' do
      it 'should not create a new membership' do
        expect {
          post(
            :create,
            user_id: @user.id,
            membership: {user_id: @user.id},
            format: :json,
            token: ENV["API_TOKEN"]
          )
        }.to_not change{ Membership.count }
      end
    end
  end
end
