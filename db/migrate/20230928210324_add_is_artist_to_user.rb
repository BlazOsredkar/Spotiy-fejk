class AddIsArtistToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_artist, :boolean, default: false
  end
end
