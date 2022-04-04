# frozen_string_literal: true

class RecipesSearch
  extend Dry::Initializer

  param :ingredients, Types::Array.of(Types::String).constructor { |el| el.select(&:present?) }.optional, reader: :private
  param :category_id, Types::Coercible::Integer.optional, reader: :private

  SELECT_CLAUSE = 'SELECT id, title, prep_time_minutes, cook_time_minutes, ' \
    'ratings, ingredients, image_url, author_id, category_id'
  FROM_CLAUSE = 'FROM recipes'
  ORDER_CLAUSE = 'ORDER BY jsonb_array_length(ingredients)'

  def call
    result = Recipe.find_by_sql(
      [
        select_clause,
        from_clause,
        where_clause,
        order_query,
      ].compact.join(' ')
    )

    preload_associations(result)
    result
  end

  private

  attr_reader :ingredients, :category_id

  def select_clause
    SELECT_CLAUSE
  end

  def from_clause
    FROM_CLAUSE
  end

  def where_clause
    return if category_id_where_clause.nil? && ingredients_where_clause.nil?

    "WHERE #{[category_id_where_clause, ingredients_where_clause].compact.join(" AND ")}"
  end

  def category_id_where_clause
    return unless category_id.present?

    @category_id_where_clause ||= "category_id = #{category_id}"
  end

  def ingredients_where_clause
    return unless ingredients.present?

    @ingredients_where_clause ||= "ingredients_tsvector @@ websearch_to_tsquery('simple', #{ingredients_tsquery})"
  end

  def order_query
    return unless ingredients.present?

    'ORDER BY jsonb_array_length(ingredients)'
  end

  def ingredients_tsquery
    ActiveRecord::Base.connection.quote(
      ingredients.map { |ingredient| "\"#{ingredient}\"" }.join(' & ')
    )
  end

  def preload_associations(result)
    ActiveRecord::Associations::Preloader.new(
      records: result,
      associations: [:author, :category]
    ).call
  end
end
