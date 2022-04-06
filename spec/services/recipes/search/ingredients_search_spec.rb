# frozen_string_literal: true

RSpec.describe Recipes::Search::IngredientsSearch do
  describe '#call' do
    subject { described_class.new(searched_ingredients).call }

    context 'searched_ingredients is empty' do
      let!(:searched_ingredients) { [] }

      it { is_expected.to eq(nil) }
    end

    context 'searched_ingredients are present' do
      let!(:searched_ingredients) { ['milk', 'butter'] }

      it 'returns proper query string' do
        expect(subject).to eq("ingredients_tsvector @@ websearch_to_tsquery('simple', '\"milk\" OR \"butter\"')")
      end
    end
  end
end
