class CreatePlaylists < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists do |t|
      t.string :name, null: false
      t.integer :user_id, null: false
      t.text :cover_image, null: false
      t.boolean :privacy, null: false

      t.timestamps
    end

    add_index :playlists, :user_id
    add_foreign_key :playlists, :users, column: :user_id, on_delete: :nullify, on_update: :nullify
  end
end
