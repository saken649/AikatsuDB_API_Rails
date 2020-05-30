class CreateAlbumTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :album_tracks do |t|
      t.string :album_id, limit: 64, null: false
      t.integer :tracks, null: false
      t.integer :disc_number, null: false
      t.timestamps
      t.datetime :deleted_at
    end
    add_foreign_key :album_tracks, :albums
  end
end
