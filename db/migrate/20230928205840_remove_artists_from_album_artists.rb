class RemoveArtistsFromAlbumArtists < ActiveRecord::Migration[7.0]
  def change
    remove_column :albums_artists, :artist_id, :integer
  end
end
