class AddUserToAlbumsSongs < ActiveRecord::Migration[7.0]
  def change
    add_reference :albums_artists, :user, null: false, foreign_key: true
  end
end
