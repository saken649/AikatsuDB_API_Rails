class CreateCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters, id: :string, limit: 16 do |t|
      t.string :name_family, limit: 8, null: false
      t.string :name_first, limit: 8, null: false
      t.string :name_family_kana, limit: 16, null: false
      t.string :name_first_kana, limit: 16, null: false
      t.string :voice_actor_family, limit: 8, null: false
      t.string :voice_actor_first, limit: 8, null: false
      t.string :voice_actor_family_kana, limit: 16, null: false
      t.string :voice_actor_first_kana, limit: 16, null: false
      t.integer :order
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
