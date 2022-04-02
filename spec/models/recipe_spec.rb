# frozen_string_literal: true

RSpec.describe Recipe do
  describe 'db columns' do
    it { is_expected.to have_db_column(:title).with_options(null: false) }
    it { is_expected.to have_db_column(:cook_time_minutes).with_options(null: false) }
    it { is_expected.to have_db_column(:prep_time_minutes).with_options(null: false) }
    it { is_expected.to have_db_column(:ratings) }
    it { is_expected.to have_db_column(:image_url) }
    it { is_expected.to have_db_column(:ingredients) }
    it { is_expected.to have_db_column(:author_id) }
    it { is_expected.to have_db_column(:category_id) }
    it { is_expected.to have_db_column(:cuisine_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:author).optional(true) }
    it { is_expected.to belong_to(:category).optional(true) }
    it { is_expected.to belong_to(:cuisine).optional(true) }
  end

  describe 'validations' do
    subject { described_class.new(title: 'Test', cook_time_minutes: 10, prep_time_minutes: 10) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:cook_time_minutes) }
    it { is_expected.to validate_presence_of(:prep_time_minutes) }
  end
end
