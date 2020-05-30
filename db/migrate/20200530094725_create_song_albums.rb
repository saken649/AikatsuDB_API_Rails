class CreateSongAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :song_albums do |t|
      t.string :song_id, limit: 64, null: false
      t.integer :track_number, null: false
      t.integer :disc_number
      t.timestamps
      t.datetime :deleted_at
    end
    add_foreign_key :song_albums, :songs
  end
end
