# frozen_string_literal: true

FactoryBot.define do
  factory :cuisine do
    sequence(:name) { |i| "Cuisine #{i}" }
  end
end
