class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs, id: :string, limit: 64 do |t|
      t.string :parent_song_id, limit: 64
      t.string :title, limit: 128
      t.string :title_kana, limit: 255
      t.string :sub_title, limit: 128
      t.integer :is_short, limit: 1, null: false
      t.string :song_type, limit: 8
      t.integer :series_id, null: false
      t.timestamps
      t.datetime :deleted_at
    end
    add_foreign_key :songs, :songs, column: :parent_song_id
    add_foreign_key :songs, :series
  end
end
