# frozen_string_literal: true

module Recipes
  module Search
    class Result
      extend Dry::Initializer

      param :searched_ingredients, Types::Array.of(Types::String).constructor { |el| el.select(&:present?) }.optional, reader: :private
      param :category_id, Types::Coercible::Integer.optional, reader: :private

      SELECT_CLAUSE = 'SELECT id, title, prep_time_minutes, cook_time_minutes, ' \
        'ratings, ingredients, image_url, author_id, category_id'
      FROM_CLAUSE = 'FROM recipes'

      def call
        Recipe.find_by_sql(
          [
            select_clause,
            from_clause,
            where_clause,
            order_query
          ].compact.join(' ')
        )
      end

      private

      attr_reader :searched_ingredients, :category_id

      def select_clause
        SELECT_CLAUSE
      end

      def from_clause
        FROM_CLAUSE
      end

      def where_clause
        ::Recipes::Search::WhereClause.new(searched_ingredients, category_id).call
      end

      def order_query
        return if searched_ingredients.blank?

        "ORDER BY #{rank} DESC"
      end

      def rank
        ::Recipes::Search::Rank.new(searched_ingredients).call
      end
    end
  end
end
