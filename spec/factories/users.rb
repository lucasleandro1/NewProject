# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "Lucas" }
    cpf { "12345679845" }
    telephone { "87992109391" }
    email { "lucas@gmail.com" }
  end
end
