class CreateRecipes < ActiveRecord::Migration[7.0]
  def up
    create_table :recipes do |t|
      t.string :title, null: false
      t.integer :cook_time_minutes, null: false
      t.integer :prep_time_minutes, null: false
      t.decimal :ratings
      t.string :image_url
      t.jsonb :ingredients, default: '[]'

      t.references :author, index: true
      t.references :category, index: true
      t.references :cuisine, index: true

      t.timestamps
    end

    execute <<~SQL
      ALTER TABLE recipes ADD COLUMN ingredients_tsvector tsvector GENERATED ALWAYS AS (to_tsvector('english', ingredients)) STORED;
      CREATE INDEX ingredients_tsvector ON recipes USING gin(ingredients_tsvector);
    SQL
  end

  def down
    drop_table :recipes
  end
end
