class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :title, null: false
      t.integer :cook_time_minutes, null: false
      t.integer :prep_time_minutes, null: false
      t.decimal :ratings
      t.string :image_url
      t.string :ingredients, array: true, default: []

      t.references :authors, index: true
      t.references :categories, index: true
      t.references :cuisines, index: true

      t.timestamps
    end

    add_index :recipes, :ingredients, using: 'gin'
  end
end
