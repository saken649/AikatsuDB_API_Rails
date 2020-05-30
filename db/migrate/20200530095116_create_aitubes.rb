class CreateAitubes < ActiveRecord::Migration[6.0]
  def change
    create_table :aitubes do |t|
      t.string :song_id, limit: 64, null: false
      t.string :youtube_id, limit: 16, null: false
      t.integer :order
      t.timestamps
      t.datetime :deleted_at
    end
    add_foreign_key :aitubes, :songs
  end
end
