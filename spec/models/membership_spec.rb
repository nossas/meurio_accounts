require 'spec_helper'

describe Membership do
  it { should belong_to :organization }
  it { should validate_presence_of(:organization_id) }
  it { should validate_presence_of(:user) }

  describe "#after_create" do
    before do
      allow_any_instance_of(User).to receive(:update_location_and_mailchimp).and_return(true)
      @user = User.make!
    end

    it 'calls update method from user' do
      expect(@user).to receive(:update_location_and_mailchimp).once
      Membership.make! user: @user
    end
  end
end
