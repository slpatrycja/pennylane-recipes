# frozen_string_literal: true

RSpec.describe InternalApi::RecipesController do
  let!(:category) { create(:category) }
  let!(:recipe1) do
    create(:recipe,
           title: 'Recipe1',
           ingredients: ['1 gallon whole milk', '1 cup plain yogurt with active cultures'],
           category: category
          )
  end
  let!(:recipe2) do
    create(:recipe,
           title: 'Recipe2',
           ingredients: ['1 cup milk', '1 tablespoon lemon juice'],
           category: category
          )
  end
  let!(:recipe3) do
    create(:recipe,
           title: 'Recipe3',
           ingredients: ['1 cup all-purpose flour', '1 cup yellow cornmeal'],
           category: nil
          )
  end

  describe 'GET #index' do
    subject { get :index, params: params }

    context 'no filters' do
      let(:params) { {} }
      let(:expected_result) do
        [
          {
            'title' => recipe1.title,
            'prep_time_minutes' => recipe1.prep_time_minutes,
            'cook_time_minutes' => recipe1.cook_time_minutes,
            'ingredients' => ['1 gallon whole milk', '1 cup plain yogurt with active cultures'],
            'category' => category.name
          },
          {
            'title' => recipe2.title,
            'prep_time_minutes' => recipe2.prep_time_minutes,
            'cook_time_minutes' => recipe2.cook_time_minutes,
            'ingredients' => ['1 cup milk', '1 tablespoon lemon juice'],
            'category' => category.name
          },
          {
            'title' => recipe3.title,
            'prep_time_minutes' => recipe3.prep_time_minutes,
            'cook_time_minutes' => recipe3.cook_time_minutes,
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
            'title' => recipe1.title,
            'prep_time_minutes' => recipe1.prep_time_minutes,
            'cook_time_minutes' => recipe1.cook_time_minutes,
            'ingredients' => ['1 gallon whole milk', '1 cup plain yogurt with active cultures'],
            'category' => category.name
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
            'title' => recipe1.title,
            'prep_time_minutes' => recipe1.prep_time_minutes,
            'cook_time_minutes' => recipe1.cook_time_minutes,
            'ingredients' => ['1 gallon whole milk', '1 cup plain yogurt with active cultures'],
            'category' => category.name
          },
          {
            'title' => recipe2.title,
            'prep_time_minutes' => recipe2.prep_time_minutes,
            'cook_time_minutes' => recipe2.cook_time_minutes,
            'ingredients' => ['1 cup milk', '1 tablespoon lemon juice'],
            'category' => category.name
          }
        ]
      end

      it 'returns all recipes with category matching the filters' do
        subject

        expect(JSON.parse(response.body)).to match_array(expected_result)
      end
    end

    context 'with both category and ingredients filters' do
      let(:params) { { query: ['lemon'], category_id: category.id } }

      let(:expected_result) do
        [
          {
            'title' => recipe2.title,
            'prep_time_minutes' => recipe2.prep_time_minutes,
            'cook_time_minutes' => recipe2.cook_time_minutes,
            'ingredients' => ['1 cup milk', '1 tablespoon lemon juice'],
            'category' => category.name
          }
        ]
      end

      it 'returns all recipes with category and ingredients matching the filters' do
        subject

        expect(JSON.parse(response.body)).to match_array(expected_result)
      end
    end
  end
end
