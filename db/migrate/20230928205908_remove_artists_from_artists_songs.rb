class RemoveArtistsFromArtistsSongs < ActiveRecord::Migration[7.0]
  def change
    remove_column :artists_songs, :artist_id, :integer
  end
end
