# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validations' do
    context 'when valid' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:cpf) }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:telephone) }
    end

    context 'when not valid' do
      let(:user) { build(:user) }

      it 'without name' do
        user.name = nil
        expect(user).to_not be_valid
        expect(user.errors[:name]).to include("can't be blank")
      end

      it 'without email' do
        user.email = nil
        expect(user).to_not be_valid
        expect(user.errors[:email]).to include("can't be blank")
      end

      it 'without telephone' do
        user.telephone = nil
        expect(user).to_not be_valid
        expect(user.errors[:telephone]).to include("can't be blank")
      end

      it 'without CPF' do
        user.cpf = nil
        expect(user).to_not be_valid
        expect(user.errors[:cpf]).to include("can't be blank")
      end
    end
  end

  describe '.uniqueness' do
    subject { create(:user) }
    it { is_expected.to validate_uniqueness_of(:cpf).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  describe '.find_by' do
    it 'returns nil when no user is found by CPF' do
      expect(User.find_by(cpf: '00000000000')).to be_nil
    end
  end
end
