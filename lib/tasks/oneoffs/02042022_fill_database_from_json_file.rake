require 'json'

namespace :oneoffs do
  desc 'Fill in database with data from json file'
  task '02042022_fill_database_from_json_file' => :environment do
    puts 'Starting...'

    json_from_file = File.read(Rails.root.join('lib', 'recipes-en.json'))
    data = JSON.parse(json_from_file)

    ActiveRecord::Base.transaction do
      data.each do |obj|
        category = Category.find_or_create_by!(name: obj['category']) if obj['category'].present?
        author = Author.find_or_create_by!(username: obj['author']) if obj['author'].present?
        cuisine = Cuisine.find_or_create_by!(name: obj['cuisine']) if obj['cuisine'].present?

        recipe = Recipe.create!(
          title: obj['title'],
          cook_time_minutes: obj['cook_time'],
          prep_time_minutes: obj['prep_time'],
          ratings: obj['ratings'],
          image_url: obj['image'],
          ingredients: obj['ingredients'],
          author_id: author&.id,
          category_id: category&.id,
          cuisine_id: cuisine&.id
        )
      end

      puts 'Done!'
    end
  end
end
