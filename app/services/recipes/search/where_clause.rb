# frozen_string_literal: true

module Recipes
  module Search
    class WhereClause
      extend Dry::Initializer

      param :searched_ingredients, Types::Array.of(Types::String).constructor { |el| el.select(&:present?) }.optional, reader: :private
      param :category_id, Types::Coercible::Integer.optional, reader: :private

      WHERE_JOIN_OPERATOR = ' AND '

      def call
        return if category_search.nil? && ingredients_search.nil?

        "WHERE #{[category_search, ingredients_search].compact.join(WHERE_JOIN_OPERATOR)}"
      end

      private

      attr_reader :searched_ingredients, :category_id

      def category_search
        @category_search ||= Recipes::Search::CategorySearch.new(category_id).call
      end

      def ingredients_search
        @ingredients_search ||= Recipes::Search::IngredientsSearch.new(searched_ingredients).call
      end
    end
  end
end
