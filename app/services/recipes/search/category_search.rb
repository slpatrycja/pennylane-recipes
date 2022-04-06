# frozen_string_literal: true

module Recipes
  module Search
    class CategorySearch
      extend Dry::Initializer

      param :category_id, Types::Coercible::Integer.optional, reader: :private

      def call
        return if category_id.blank?

        @category_id_where_clause ||= "category_id = #{category_id}"
      end

      private

      attr_reader :category_id
    end
  end
end
