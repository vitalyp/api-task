# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    user    { nil }
    title   { Faker::Book.title }
    content { Faker::Lorem.sentence }
    ip      { Faker::Internet.ip_v4_address }
  end
end
