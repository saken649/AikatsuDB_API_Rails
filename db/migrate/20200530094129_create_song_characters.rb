class CreateSongCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :song_characters do |t|
      t.string :song_id, limit: 64, null: false
      t.string :character_id, limit: 16, null: false
      t.timestamps
      t.datetime :deleted_at
    end
    add_foreign_key :song_characters, :songs
    add_foreign_key :song_characters, :characters
  end
end
