class User < ApplicationRecord
  validates :name, :telephone, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
