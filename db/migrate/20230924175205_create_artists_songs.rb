class CreateArtistsSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :artists_songs do |t|
      t.integer :song_id
      t.integer :artist_id

      t.timestamps
    end

    add_index :artists_songs, :artist_id
    add_index :artists_songs, :song_id
    add_foreign_key :artists_songs, :artists, column: :artist_id, on_delete: :nullify, on_update: :nullify
    add_foreign_key :artists_songs, :songs, column: :song_id, on_delete: :nullify, on_update: :nullify
  end
end