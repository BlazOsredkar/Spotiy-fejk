class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :length
      t.integer :user_id, null: false
      t.string :cover_image, null: false
      t.text :path, null: false

      t.timestamps
    end

    add_index :songs, :user_id
    add_foreign_key :songs, :users, column: :user_id, on_delete: :nullify, on_update: :nullify
  end
end
