class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :username, null: false, unique: true

      t.timestamps
    end
  end
end
