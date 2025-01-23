# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserManager::Creator, type: :service do
  let(:user_params) { attributes_for(:user) }

  describe "#call" do
    subject { described_class.new(user_params).call }

    context "when user do not exist" do
      it "create new user" do
        expect(subject[:success]).to be_truthy
        expect(subject[:resource]).to be_a(User)
        expect(subject[:resource].cpf).to eq(user_params[:cpf])
      end
    end

    context "when user already exists" do
      before { create(:user, cpf: user_params[:cpf]) }

      it "does not create new user" do
        expect { subject }.not_to change(User, :count)
        expect(subject[:success]).to be_falsey
        expect(subject[:error_message][:message]).to eq("user_exists")
      end
    end
  end
end
