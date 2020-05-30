class CreateSingers < ActiveRecord::Migration[6.0]
  def change
    create_table :singers, id: :string, limit: 32 do |t|
      t.string :parent_singer_id, limit: 32
      t.string :name_family, limit: 8
      t.string :name_first, limit: 8
      t.string :name_family_kana, limit: 16
      t.string :name_first_kana, limit: 16
      t.string :display_name, limit: 16
      t.string :group_id, limit: 32
      t.integer :order
      t.timestamps
      t.datetime :deleted_at
    end
    add_foreign_key :singers, :groups
    add_foreign_key :singers, :singers, column: :parent_singer_id
  end
end
