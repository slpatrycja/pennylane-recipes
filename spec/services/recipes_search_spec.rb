# frozen_string_literal: true

RSpec.describe RecipesSearch do
  let!(:recipe1) do
    Recipe.create!(
      title: 'Recipe1',
      cook_time_minutes: 10,
      prep_time_minutes: 10,
      ingredients: ['1 gallon whole milk', '1 cup plain yogurt with active cultures']
    )
  end
  let!(:recipe2) do
    Recipe.create!(
      title: 'Recipe2',
      cook_time_minutes: 10,
      prep_time_minutes: 10,
      ingredients: ['1 cup milk', '1 tablespoon lemon juice']
    )
  end
  let!(:recipe3) do
    Recipe.create!(
      title: 'Recipe3',
      cook_time_minutes: 10,
      prep_time_minutes: 10,
      ingredients: ['1 cup all-purpose flour', '1 cup yellow cornmeal']
    )
  end

  describe '#call' do
    subject { described_class.new(query, nil).call }

    context 'no query given' do
      context 'query is nil' do
        let(:query) { nil }

        it 'returns all recipes from the database' do
          expect(subject.to_a).to match_array([recipe1, recipe2, recipe3])
        end
      end

      context 'query is an empty array' do
        let(:query) { [] }

        it 'returns all recipes from the database' do
          expect(subject.to_a).to match_array([recipe1, recipe2, recipe3])
        end
      end

      context 'query is present but contains only empty strings' do
        let(:query) { ["", "  "] }

        it 'returns all recipes from the database' do
          expect(subject.to_a).to match_array([recipe1, recipe2, recipe3])
        end
      end
    end

    context 'query is given' do
      let(:query) { ['milk'] }

      it 'returns all recipes with ingredients matching the query' do
        expect(subject.to_a).to match_array([recipe1, recipe2])
      end
    end
  end
end
