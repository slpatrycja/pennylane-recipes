# frozen_string_literal: true

RSpec.describe Recipes::Search::CategorySearch do
  describe '#call' do
    subject { described_class.new(category_id).call }

    context 'category is nil' do
      let!(:category_id) { nil }

      it { is_expected.to eq(nil) }
    end

    context 'category is present' do
      let!(:category_id) { 1 }

      it 'returns proper query string' do
        expect(subject).to eq("category_id = 1")
      end
    end
  end
end
