# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    sequence(:username) { |i| "author_#{i}" }
  end
end
