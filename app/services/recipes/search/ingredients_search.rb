# frozen_string_literal: true

module Recipes
  module Search
    class IngredientsSearch
      extend Dry::Initializer

      param :searched_ingredients, Types::Array.of(Types::String).constructor { |el| el.select(&:present?) }.optional, reader: :private

      TSQUERY_OPERATOR = ' OR '

      def call
        return if searched_ingredients.blank?

        @ingredients_where_clause ||= "ingredients_tsvector @@ websearch_to_tsquery('simple', #{ingredients_tsquery})"
      end

      private

      attr_reader :searched_ingredients

      def ingredients_tsquery
        ActiveRecord::Base.connection.quote(
          searched_ingredients.map { |ingredient| "\"#{ingredient.strip}\"" }.join(TSQUERY_OPERATOR)
        )
      end
    end
  end
end
