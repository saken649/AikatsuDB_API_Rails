class CreateCharacterSingers < ActiveRecord::Migration[6.0]
  def change
    create_table :character_singers do |t|
      t.string :character_id, limit: 16, null: false
      t.string :singer_id, limit: 32, null: false
      t.integer :is_current, limit: 1, null: false
      t.timestamps
      t.datetime :deleted_at
    end
    add_foreign_key :character_singers, :characters
    add_foreign_key :character_singers, :singers
  end
end
