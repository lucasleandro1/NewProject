# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserManager::List do
  describe "#call" do
    subject(:service_call) { described_class.new.call }

    context "when exist users in database" do
      let!(:users) { create_list(:user, 3) }

      it "returns a successful" do
        expect(service_call).to include(success: true)
      end

      it "returns all users" do
        expect(service_call[:resources]).to match_array(users)
      end
    end

    context "when no exist users in database" do
      it "returns an empty" do
        expect(service_call[:resources]).to eq([])
      end
    end

    context "when an error occurs" do
      before do
        allow(User).to receive(:all).and_raise(StandardError, "Something went wrong")
      end

      it "returns an unsuccessful" do
        expect(service_call).to include(success: false)
      end
    end
  end
end
