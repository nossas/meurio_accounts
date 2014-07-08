require 'spec_helper'

describe UsersController do
  describe 'POST create' do
    before { @user = stub_model User }
    let(:params) {{
      first_name: 'Nícolas',
      last_name: 'Iensen',
      email: 'nicolas@minhascidades.org.br',
      password: '123456',
      organization_id: 1
    }}

    context 'when this is a new user' do
      before { User.stub(:find_by_email).and_return(nil) }
      it 'should not update mailchimp subscription' do
        @user.should_not_receive(:update_mailchimp_subscription)
        post :create, user: params, format: :json
      end
    end

    context 'when there is no organization_id' do
      before { User.stub(:find_by_email).and_return(@user) }
      before { params.delete(:organization_id) }
      it 'should not update mailchimp subscription' do
        @user.should_not_receive(:update_mailchimp_subscription)
        post :create, user: params, format: :json
      end
    end

    context 'when this is an existing user' do
      before { User.stub(:find_by_email).and_return(@user) }
      it 'should update mailchimp subscription' do
        @user.should_receive(:update_mailchimp_subscription)
        post :create, user: params, format: :json
      end
    end
  end
end
