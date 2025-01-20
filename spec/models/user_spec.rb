# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validations' do
    context 'when present' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:cpf) }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:telephone) }
    end
  end

  describe '.uniqueness' do
    subject { create(:user) }
    it { is_expected.to validate_uniqueness_of(:cpf).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end
end
