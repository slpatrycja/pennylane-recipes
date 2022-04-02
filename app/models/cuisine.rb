# frozen_string_literal: true

class Cuisine < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :recipes, dependent: :nullify
end
