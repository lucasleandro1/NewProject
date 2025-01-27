# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "GET #index" do
    subject(:get_index) { get :index }

    context "when service returns success" do
      let(:users) { create_list(:user, 5) }

      it "returns a successful" do
        allow(UserManager::List).to receive_message_chain(:new, :call).and_return({ success: true, resources: users })
        get_index
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(users.size)
      end
    end

    context "when service fails" do
      it "returns an unprocessable entity status" do
        allow(UserManager::List).to receive_message_chain(:new, :call).and_return({ success: false, error_message: "Something went wrong" })
        get_index
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["error_message"]).to eq("Something went wrong")
      end
    end
  end

  describe "POST #create" do
    subject(:post_create) { post :create, params: params }

    let(:params) { { user: attributes_for(:user) } }

    context "when create user successfully" do
      it "created status" do
        user = build(:user)
        allow(UserManager::Creator).to receive_message_chain(:new, :call).and_return({ success: true, resource: user })
        post_create
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)["email"]).to eq(user.email)
      end
    end

    context "when fails create user" do
      it "returns an unprocessable entity" do
        allow(UserManager::Creator).to receive_message_chain(:new, :call).and_return({ success: false, error_message: "Invalid data" })
        post_create
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["error"]).to eq("Invalid data")
      end
    end
  end
end
