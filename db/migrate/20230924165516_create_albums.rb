class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.string :name, null: false
      t.string :description
      t.string :cover_image, null: false

      t.timestamps
    end
  end
end
