# frozen_string_literal: true

RSpec.describe RecipesSearch do
  let!(:category) { create(:category) }
  let!(:recipe1) do
    Recipe.create!(
      title: 'Recipe1',
      cook_time_minutes: 10,
      prep_time_minutes: 10,
      ingredients: ['1 gallon whole milk', '1 cup plain yogurt with active cultures'],
      category: category
    )
  end
  let!(:recipe2) do
    Recipe.create!(
      title: 'Recipe2',
      cook_time_minutes: 10,
      prep_time_minutes: 10,
      ingredients: ['1 cup milk', '1 tablespoon lemon juice'],
      category: category
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
    subject { described_class.new(ingredients, category_id).call }

    let(:ingredients) { nil }
    let(:category_id) { nil }

    describe 'ingredients search' do
      context 'no ingredients given' do
        context 'ingredients are nil' do
          it 'returns all recipes from the database' do
            expect(subject.to_a).to match_array([recipe1, recipe2, recipe3])
          end
        end

        context 'ingredients are an empty array' do
          let(:ingredients) { [] }

          it 'returns all recipes from the database' do
            expect(subject.to_a).to match_array([recipe1, recipe2, recipe3])
          end
        end

        context 'ingredients are present but contains only empty strings' do
          let(:query) { ["", "  "] }

          it 'returns all recipes from the database' do
            expect(subject.to_a).to match_array([recipe1, recipe2, recipe3])
          end
        end
      end

      context 'ingredients are given' do
        let(:ingredients) { ['milk'] }

        it 'returns all recipes with ingredients matching the query' do
          expect(subject.to_a).to match_array([recipe1, recipe2])
        end
      end
    end

    describe 'category filtering' do
      context 'category_id is nil' do
        it 'returns all recipes from the database' do
          expect(subject.to_a).to match_array([recipe1, recipe2, recipe3])
        end
      end

      context 'category_id is given' do
        context 'there are recipes for given category' do
          let(:category_id) { category.id }

          it 'returns all recipes with category matching the query' do
            expect(subject.to_a).to match_array([recipe1, recipe2])
          end
        end

        context 'there are no recipes for given category' do
          let(:category_id) { 12345 }

          it 'returns no recipes' do
            expect(subject.to_a).to eq([])
          end
        end
      end
    end

    describe 'combined filtering' do
      let(:category_id) { category.id }
      let(:ingredients) { ['lemon'] }

      it 'returns recipes with matching ingredients and category' do
        expect(subject.to_a).to eq([recipe2])
      end
    end
  end
end
