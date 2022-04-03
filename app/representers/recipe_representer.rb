# frozen_string_literal: true

class RecipeRepresenter < SimpleRepresenter::Representer
  property :title
  property :prep_time_minutes
  property :cook_time_minutes
  property :ratings
  property :ingredients
  property :image_url

  computed :author
  computed :category

  def author
    represented.author&.username
  end

  def category
    represented.category&.name
  end
end
