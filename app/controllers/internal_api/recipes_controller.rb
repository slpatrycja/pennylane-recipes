# frozen_string_literal: true

module InternalApi
  class RecipesController < BaseController
    def index
      collection = ::RecipesSearch.new(search_params[:query], search_params[:category_id]).call

      render json: RecipeRepresenter.for_collection(collection).to_json
    end

    private

    def search_params
      params.permit(:category_id, query: [])
    end
  end
end
