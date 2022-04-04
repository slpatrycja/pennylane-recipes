# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    sequence(:title) { |i| "Recipe #{i}" }
    cook_time_minutes { 10 }
    prep_time_minutes { 10 }
    ingredients { ['milk', 'cheese'] }

    category
  end
end
