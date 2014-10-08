require 'spec_helper'

describe API::V1::UsersController do
  describe "POST create" do
    context "when the HTTP token is not valid" do
      it "should respond with 401" do
        post :create, user: {first_name: "Leonel", last_name: "Messi", email: "messi@minhascidades.org.br", password: "123456"}, format: :json
        expect(subject).to respond_with 401
      end
    end

    context "when the HTTP token is valid" do
      before { request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(ENV["API_TOKEN"]) }

      context "when the params are valid" do
        it "should respond with 201" do
          post :create, user: {first_name: "Leonel", last_name: "Messi", email: "messi@minhascidades.org.br", password: "123456"}, format: :json
          expect(subject).to respond_with 201
        end
      end

      context "when the params are not valid" do
        it "should respond with 422" do
          post :create, user: {first_name: "Leonel", last_name: "Messi", email: "messi@minhascidades.org.br"}, format: :json
          expect(subject).to respond_with 422
        end
      end
    end
  end
end
