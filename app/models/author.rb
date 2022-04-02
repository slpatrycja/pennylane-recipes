# frozen_string_literal: true

class Author < ApplicationRecord
  validates :username, presence: true, uniqueness: true

  has_many :recipes, dependent: :destroy
end
