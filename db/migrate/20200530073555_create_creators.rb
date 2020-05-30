class CreateCreators < ActiveRecord::Migration[6.0]
  def change
    create_table :creators, id: :string, limit: 32 do |t|
      t.string :name_family, limit: 8
      t.string :name_first, limit: 8
      t.string :name_family_kana, limit: 16
      t.string :name_first_kana, limit: 16
      t.string :artist_name, limit: 32
      t.string :artist_name_kana, limit: 64
      t.string :production_id, limit: 32
      t.timestamps
      t.datetime :deleted_at
    end
    add_foreign_key :creators, :productions
  end
end
