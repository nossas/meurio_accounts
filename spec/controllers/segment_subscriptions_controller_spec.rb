require 'spec_helper'

describe SegmentSubscriptionsController do
  describe 'POST create' do
    before do
      @user = User.make!
      @organization = Organization.make!
      @lists = double('lists')
      allow(Gibbon::API).to receive(:lists).and_return(@lists)
    end

    context 'when the right parameters are passed in' do
      it 'subscribes the user to the segment' do
        expect(@lists).to receive(:static_segment_members_add)

        post(
          :create,
          user_id: @user.id,
          segment_subscription: { organization_id: @organization.id, segment_id: '123' },
          format: :json,
          token: ENV["API_TOKEN"]
        )
      end
    end

    context 'when parameters are missing' do
      it 'does not subscribe the user to the segment' do
        expect(@lists).to_not receive(:static_segment_members_add)

        post(
          :create,
          user_id: @user.id,
          segment_subscription: { organization_id: nil, segment_id: nil },
          format: :json,
          token: ENV["API_TOKEN"]
        )
      end
    end
  end
end
