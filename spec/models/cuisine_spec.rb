# frozen_string_literal: true

RSpec.describe Cuisine do
  describe 'db columns' do
    it { is_expected.to have_db_column(:name).with_options(null: false) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:recipes).dependent(:nullify) }
  end

  describe 'validations' do
    subject { described_class.new(name: 'Test') }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
