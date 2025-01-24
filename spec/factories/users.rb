# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    cpf { Faker::Number.unique.number(digits: 11) }
    telephone { Faker::PhoneNumber.phone_number }
  end
end
