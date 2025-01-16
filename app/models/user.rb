class User < ApplicationRecord
  validates :name, :cpf, :email, :telephone, presence: true
  validates :cpf, presence: true, uniqueness: true
end
