# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_attributes) do
    {
      name: 'User Exemplo',
      cpf: '12345678901',
      email: 'user@gmail.com',
      telephone: '88992109391'
    }
  end

  describe 'validações' do
    it 'é válido com todos os atributos' do
      expect(User.new(valid_attributes)).to be_valid
    end

    context 'campos obrigatórios' do
      it 'é inválido sem nome' do
        valid_attributes[:name] = nil
        expect(User.new(valid_attributes)).to_not be_valid
      end

      it 'é inválido sem email' do
        valid_attributes[:email] = nil
        expect(User.new(valid_attributes)).to_not be_valid
      end

      it 'é inválido sem telefone' do
        valid_attributes[:telephone] = nil
        expect(User.new(valid_attributes)).to_not be_valid
      end

      it 'é inválido sem CPF' do
        valid_attributes[:cpf] = nil
        expect(User.new(valid_attributes)).to_not be_valid
      end
    end

    context 'validação de unicidade' do
      it 'é inválido com CPF duplicado' do
        User.create!(name: 'user 1', cpf: valid_attributes[:cpf], email: 'user1@example.com', telephone: '1234567890')
        duplicate_user = User.new(name: 'user 2', cpf: valid_attributes[:cpf], email: 'user2@example.com', telephone: '0987654321')
        expect(duplicate_user).to_not be_valid
        expect(duplicate_user.errors[:cpf]).to include('has already been taken')
      end
    end
  end

  describe 'métodos de classe' do
    it 'retorna nil se o usuário não existir' do
      expect(User.find_by(cpf: '00000000000')).to be_nil
    end
  end
end
