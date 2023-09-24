class CreateSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :description
      t.string :length
      t.belongs_to :album, index: true, foreign_key: true
      t.timestamps
    end
  end
end
