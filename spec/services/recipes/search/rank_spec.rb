# frozen_string_literal: true

RSpec.describe Recipes::Search::Rank do
  describe '#call' do
    subject { described_class.new(searched_ingredients).call }

    let!(:searched_ingredients) { ['milk', 'butter'] }

    it 'returns proper query string' do
      expect(subject).to eq(
        "LEAST(array_length(ARRAY(
          SELECT UNNEST(tsvector_to_array(ingredients_tsvector))
          INTERSECT
          SELECT UNNEST(string_to_array('milk butter', ' '))
        ), 1), 2.0) / jsonb_array_length(ingredients)"
      )
    end
  end
end
