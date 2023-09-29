class AddUserToArtistsSongs < ActiveRecord::Migration[7.0]
  def change
    add_reference :artists_songs, :user, null: false, foreign_key: true
  end
end
