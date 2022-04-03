# frozen_string_literal: true

module InternalApi
  class CategoriesController < BaseController
    def index
      render json: Category.pluck(:id, :name).to_json
    end
  end
end
