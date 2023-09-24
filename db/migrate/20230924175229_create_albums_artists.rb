class CreateAlbumsArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :albums_artists do |t|
      t.integer :album_id
      t.integer :artist_id

      t.timestamps
    end

    add_index :albums_artists, :artist_id
    add_index :albums_artists, :album_id
    add_foreign_key :albums_artists, :artists, column: :artist_id, on_delete: :nullify, on_update: :nullify
    add_foreign_key :albums_artists, :albums, column: :album_id, on_delete: :nullify, on_update: :nullify
  end
end