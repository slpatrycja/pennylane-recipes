# frozen_string_literal: true

class Recipe < ApplicationRecord
  validates :title, :cook_time_minutes, :prep_time_minutes, presence: true

  belongs_to :author
  belongs_to :category, optional: true
  belongs_to :cuisine, optional: true
end
