# frozen_string_literal: true

module InternalApi
  class RecipesController < BaseController
    def index
      render json: Recipe.all
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
