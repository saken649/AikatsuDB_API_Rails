class CreateSongCreators < ActiveRecord::Migration[6.0]
  def change
    create_table :song_creators do |t|
      t.string :song_id, limit: 64, null: false
      t.string :creator_id, limit: 32, null: false
      t.string :type, limit: 16, null: false
      t.integer :display_order
      t.integer :production_displayable, limit: 1, null: false
      t.string :delimiter_to_next, limit: 4
      t.timestamps
      t.datetime :deleted_at
    end
    add_foreign_key :song_creators, :songs
    add_foreign_key :song_creators, :creators
  end
end
