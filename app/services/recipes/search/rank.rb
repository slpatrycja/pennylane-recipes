# frozen_string_literal: true

module Recipes
  module Search
    class Rank
      extend Dry::Initializer

      param :searched_ingredients, Types::Array.of(Types::String).constructor { |el| el.select(&:present?) }.optional, reader: :private

      def call
        "LEAST(#{intersection_size}, #{searched_ingredients.length.to_f}) / jsonb_array_length(ingredients)"
      end

      private

      attr_reader :searched_ingredients, :category_id

      def intersection_size
        "array_length(#{intersection_with_ingredients_from_params}, 1)"
      end

      def intersection_with_ingredients_from_params
        "ARRAY(
          SELECT UNNEST(tsvector_to_array(ingredients_tsvector))
          INTERSECT
          SELECT UNNEST(string_to_array('#{ingredients_query}', ' '))
        )"
      end

      def ingredients_query
        searched_ingredients.join(' ')
      end
    end
  end
end
