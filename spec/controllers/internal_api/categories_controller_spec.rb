# frozen_string_literal: true

RSpec.describe InternalApi::CategoriesController do
  let!(:category1) { create(:category) }
  let!(:category2) { create(:category) }

  describe 'GET #index' do
    subject { get :index }

    let(:expected_result) do
      [
        [category1.id, category1.name],
        [category2.id, category2.name]
      ]
    end

    it 'returns all categories\' ids and names' do
      subject

      expect(JSON.parse(response.body)).to match_array(expected_result)
    end
  end
end
