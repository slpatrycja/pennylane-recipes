# frozen_string_literal: true

RSpec.describe InternalApi::RecipesController do
  let!(:category) { Category.create!(name: 'Category 1') }
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

  describe 'GET #index' do
    subject { get :index, params: params }

    context 'no filters' do
      let(:params) { {} }
      let(:expected_result) do
        [
          {
            'title' => 'Recipe1',
            'prep_time_minutes' => 10,
            'cook_time_minutes' => 10,
            'ingredients' => ['1 gallon whole milk', '1 cup plain yogurt with active cultures'],
            'category' => 'Category 1'
          },
          {
            'title' => 'Recipe2',
            'prep_time_minutes' => 10,
            'cook_time_minutes' => 10,
            'ingredients' => ['1 cup milk', '1 tablespoon lemon juice'],
            'category' => 'Category 1'
          },
          {
            'title' => 'Recipe3',
            'prep_time_minutes' => 10,
            'cook_time_minutes' => 10,
            'ingredients' => ['1 cup all-purpose flour', '1 cup yellow cornmeal']
          }
        ]
      end

      it 'returns all recipes' do
        subject

        expect(JSON.parse(response.body)).to match_array(expected_result)
      end
    end

    context 'with ingredients filters' do
      let(:params) { { query: ['yogurt'] } }

      let(:expected_result) do
        [
          {
            'title' => 'Recipe1',
            'prep_time_minutes' => 10,
            'cook_time_minutes' => 10,
            'ingredients' => ['1 gallon whole milk', '1 cup plain yogurt with active cultures'],
            'category' => 'Category 1'
          }
        ]
      end

      it 'returns all recipes with ingredients matching the filters' do
        subject

        expect(JSON.parse(response.body)).to match_array(expected_result)
      end
    end

    context 'with category filters' do
      let(:params) { { category_id: category.id } }

      let(:expected_result) do
        [
          {
            'title' => 'Recipe1',
            'prep_time_minutes' => 10,
            'cook_time_minutes' => 10,
            'ingredients' => ['1 gallon whole milk', '1 cup plain yogurt with active cultures'],
            'category' => 'Category 1'
          },
          {
            'title' => 'Recipe2',
            'prep_time_minutes' => 10,
            'cook_time_minutes' => 10,
            'ingredients' => ['1 cup milk', '1 tablespoon lemon juice'],
            'category' => 'Category 1'
          }
        ]
      end

      it 'returns all recipes with ingredients matching the filters' do
        subject

        expect(JSON.parse(response.body)).to match_array(expected_result)
      end
    end

    context 'with both category and ingredients filters' do
      let(:params) { { query: ['lemon'], category_id: category.id } }

      let(:expected_result) do
        [
          {
            'title' => 'Recipe2',
            'prep_time_minutes' => 10,
            'cook_time_minutes' => 10,
            'ingredients' => ['1 cup milk', '1 tablespoon lemon juice'],
            'category' => 'Category 1'
          }
        ]
      end

      it 'returns all recipes with ingredients matching the filters' do
        subject

        expect(JSON.parse(response.body)).to match_array(expected_result)
      end
    end
  end
end
