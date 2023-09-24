class CreatePlaylistsSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists_songs do |t|
      t.integer :playlist_id
      t.integer :song_id
      t.integer :position

      t.timestamps
    end

    add_index :playlists_songs, :playlist_id
    add_index :playlists_songs, :song_id
    add_foreign_key :playlists_songs, :playlists, column: :playlist_id, on_delete: :nullify, on_update: :nullify
    add_foreign_key :playlists_songs, :songs, column: :song_id, on_delete: :nullify, on_update: :nullify
  end
end
