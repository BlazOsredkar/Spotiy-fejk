class CreatePlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :playlists do |t|
      t.string :name
      t.string :cover_image
      t.boolean :privacy
      t.belongs_to :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
