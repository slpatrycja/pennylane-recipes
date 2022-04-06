# frozen_string_literal: true

RSpec.describe Recipes::Search::WhereClause do
  describe '#call' do
    subject { described_class.new(searched_ingredients, category_id).call }

    let!(:searched_ingredients) { [] }
    let!(:category_id) { nil }

    context 'searched_ingredients and category_id is not present' do
      it { is_expected.to eq(nil) }
    end

    context 'searched_ingredients are present' do
      let!(:searched_ingredients) { ['milk', 'butter'] }

      it 'returns proper query string' do
        expect(subject).to eq("WHERE ingredients_tsvector @@ websearch_to_tsquery('simple', '\"milk\" OR \"butter\"')")
      end
    end

    context 'category is present' do
      let!(:category_id) { 1 }

      it 'returns proper query string' do
        expect(subject).to eq("WHERE category_id = 1")
      end
    end

    context 'searched_ingredients and category_id are present' do
      let!(:searched_ingredients) { ['milk', 'butter'] }
      let!(:category_id) { 1 }

      it 'returns proper query string' do
        expect(subject).to eq(
          "WHERE category_id = 1 AND ingredients_tsvector @@ websearch_to_tsquery('simple', '\"milk\" OR \"butter\"')"
        )
      end
    end
  end
end
