require 'spec_helper'

describe UsersController do
  describe "POST create" do
    context "when there is memberships attributes" do
      let(:organization){ Organization.make! }

      it "should create the memberships" do
        expect {
          post(
            :create,
            format: :json,
            token: ENV["API_TOKEN"],
            user: {
              first_name: "Albert",
              last_name: "Einstein",
              email: "einstein@minhascidades.org.br",
              password: "sda8d7s6876das87d6a87s6da78s6d87as",
              organization_id: organization.id
            }
          )
        }.to change{ Membership.count }.by(1)
      end
    end
  end
end
