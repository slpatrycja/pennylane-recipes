# frozen_string_literal: true

RSpec.describe Author do
  describe 'db columns' do
    it { is_expected.to have_db_column(:username).with_options(null: false) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:recipes).dependent(:nullify) }
  end

  describe 'validations' do
    subject { create(:author) }

    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username) }
  end
end
