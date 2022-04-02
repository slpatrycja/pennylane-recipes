# frozen_string_literal: true

module InternalApi
  class RecipesController < BaseController
    def index
      if params[:query]
        ingredients_query = params[:query].map { |ing| "\"#{ing}\"" }.join(' & ')
        result = ActiveRecord::Base.connection.execute(
          "SELECT * FROM recipes WHERE ingredients_tsvector @@ websearch_to_tsquery('simple', '#{ingredients_query}')
           ORDER BY jsonb_array_length(ingredients)"
        )
        render json: result
      else
        render json: Recipe.all
      end
    end

    def show
      render json: Recipe.find(params.require(:id))
    end

    private

    def offset
      (params.fetch(:page, 1) - 1) * PER_PAGE
    end
  end
end
